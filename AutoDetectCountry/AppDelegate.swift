//
//  AppDelegate.swift
//  AutoDetectCountry
//
//  Created by Asset Telematics on 13/07/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
                
        return true
    }
    
}

extension AppDelegate {
    func getCountries() -> [VBCountry]? {
        var vbCountries = [VBCountry]()
        if let url = Bundle.main.url(forResource: "Countries", withExtension: "plist") {
            if let countriesFromPlist = NSArray(contentsOf: url) as? [[String: Any]] {
                countriesFromPlist.forEach { country in
                    let name = country["name"] as? String ?? ""
                    let flag = country["flag"] as? String ?? ""
                    let countryCode = country["countryCode"] as? String ?? ""
                    let regionCode = country["regionCode"] as? String ?? ""
                    
                    let country = VBCountry(
                        name: name,
                        flag: flag,
                        countryCode: countryCode,
                        regionCode: regionCode
                    )
                    
                    vbCountries.append(country)
                }
                return vbCountries
            }
        }
        
        return nil
    }
}
