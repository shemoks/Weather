//
//  UserLocation.swift
//  Weather
//
//  Created by Mac on 8/10/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import Foundation
public struct location {
 //   var cityName: String
    var long: Double
    var lat: Double
}

class UserLocation {
    static func getUserLocation() -> location {
        var result = location(long: 0.00, lat: 0.00)
        let defaults = NSUserDefaults.standardUserDefaults()
       
        result.lat = defaults.doubleForKey("lantitude")
        result.long = defaults.doubleForKey("longitude")
        print("\(result)")
        return result
    }
    
    static func setUserLocation(object: location) {
        let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(object.long, forKey: "longitude")
            defaults.setObject(object.lat, forKey: "lantitude")
     
    }
}
