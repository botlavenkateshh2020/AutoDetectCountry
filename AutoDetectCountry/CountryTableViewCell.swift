//
//  CountryTableViewCell.swift
//  AutoDetectCountry
//
//  Created by Asset Telematics on 13/07/21.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var countryFlagImageView: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setCountryOnCell(_ flagName: String, name: String) {
        if let flag = UIImage(named: flagName) {
            countryFlagImageView.image = flag
            countryNameLabel.text = name
        }
    }
}
