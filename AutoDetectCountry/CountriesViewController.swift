//
//  CountriesViewController.swift
//  AutoDetectCountry
//
//  Created by Asset Telematics on 13/07/21.
//

import UIKit

protocol VBCountriesDelegate: NSObject {
    func didSelectCountry(_ country: VBCountry)
}

class CountriesViewController: UIViewController {
    
    @IBOutlet weak var countriesTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var delegate: VBCountriesDelegate?
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var countries: [VBCountry]?
    var filterCountries: [VBCountry]?
    var isSearchActive: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        countriesTableView.delegate = self
        countriesTableView.dataSource = self
        
        countries = appDelegate.getCountries()
        
        countriesTableView.tableFooterView = UIView(frame: .zero)
        
        searchTextField.addTarget(self, action: #selector(searchCountries(_:)), for: .editingChanged)
    }

    @objc func searchCountries(_ textField: UITextField) {
        guard let searchText = textField.text else {
            return
        }
        
        if let mainCountries = countries {
            filterCountries = mainCountries.filter({ country in
                let name = country.name ?? ""
                let countryCode = country.countryCode ?? ""
                
                return (name.lowercased().contains(searchText) || countryCode.lowercased().contains(searchText))
            })
        }
        
        if let searchedCountries = filterCountries, !searchedCountries.isEmpty {
            isSearchActive = true
        } else {
            if searchText.count == 0 {
                isSearchActive = false
            } else {
                isSearchActive = true
            }
        }
        
        countriesTableView.reloadData()
        
    }

    @IBAction func backAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension CountriesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearchActive {
            if let countries = self.filterCountries {
                return countries.count
            }
        } else {
            if let countries = self.countries {
                return countries.count
            }
        }

        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell", for: indexPath) as? CountryTableViewCell else {
            return UITableViewCell()
        }
        
        if isSearchActive {
            if let country = self.filterCountries?[indexPath.row] {
                cell.setCountryOnCell(country.flag ?? "", name: country.name ?? "")
            }
        } else {
            if let country = self.countries?[indexPath.row] {
                cell.setCountryOnCell(country.flag ?? "", name: country.name ?? "")
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearchActive {
            if let country = self.filterCountries?[indexPath.row] {
                delegate?.didSelectCountry(country)
            }
        } else {
            if let country = self.countries?[indexPath.row] {
                delegate?.didSelectCountry(country)
            }
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}
