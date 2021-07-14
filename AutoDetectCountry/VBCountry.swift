//
//  VBCountry.swift
//  AutoDetectCountry
//
//  Created by Asset Telematics on 13/07/21.
//

import Foundation

struct VBCountry: Codable {
    var name: String?
    var flag: String?
    var countryCode: String?
    var regionCode: String?
    
    init(name: String?, flag: String?, countryCode: String?, regionCode: String?) {
        self.name = name
        self.flag = flag
        self.countryCode = countryCode
        self.regionCode = regionCode
    }
}
