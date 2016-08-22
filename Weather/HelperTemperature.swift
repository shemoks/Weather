//
//  HelperTemperature.swift
//  Weather
//
//  Created by Mac on 8/22/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class HelperTemperature {
    
    
    static func addToDataBase(obj: TemperatureModel ) {
        
        try! Realm().write() {
            try! Realm().add(obj)
            
        }
    }

    static func deleteByName(name: String) {
        let cheeseTemperature = try!Realm().objects(Temperature).filter("name = '\(name)'")
        try! Realm().write() {
            try! Realm().delete(cheeseTemperature)
        }
    }
    
}
