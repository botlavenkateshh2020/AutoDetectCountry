//
//  ViewController.swift
//  AutoDetectCountry
//
//  Created by Asset Telematics on 13/07/21.
//

import UIKit

class ViewController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let locale = Locale.current
        debugPrint("Region code >> \(locale.regionCode ?? "")")
        
        let regionCode = locale.regionCode ?? ""
        let countries = appDelegate.getCountries()
        
        countries?.forEach({ country in
            let regCode = country.regionCode ?? ""
            if  regionCode.lowercased() == regCode.lowercased() {
                print(regionCode)
            }
        })
        
    }
    
    @IBAction func showCountriesDataAction(_ sender: UIButton) {
        if let countriesVC = self.storyboard?.instantiateViewController(withIdentifier: "CountriesViewController") as? CountriesViewController {
            countriesVC.delegate = self
            countriesVC.modalPresentationStyle = .overFullScreen
            self.present(countriesVC, animated: true, completion: nil)
        }
    }
}


extension ViewController: VBCountriesDelegate {
    func didSelectCountry(_ country: VBCountry) {
        debugPrint("Name: \(country.name ?? "")\nCode: \(country.countryCode ?? "")\nRegion: \(country.regionCode ?? "")")
    }
}
