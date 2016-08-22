//
//  HelperCity.swift
//  Weather
//
//  Created by Mac on 8/22/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
class HelperCity {

    static func findCity(cityName: String) -> Bool {
    
    let realm = try! Realm()
    let queryCity = realm.objects(Cities.self).filter("name = '\(cityName)'")
    if queryCity.isEmpty {
        return false
        
    }
    return true
    
}
    static func addToDataBase(obj: CityModel ) {
        
        try! Realm().write() {
            try! Realm().add(obj)
        
        }
    }
    
    static func getAllCity() -> [CityModel] {
        let objs: Results<CityModel> = {
        try! Realm().objects(CityModel)
    }()
        return Array(objs)
    }
    
    static func deleteByName(name: String) {
        let cheeseCity = try!Realm().objects(CityModel).filter("name = '\(name)'")
        try! Realm().write() {
            try! Realm().delete(cheeseCity)
        }
    }
    
    static func updateCity(obj: CityModel ) {
        
        try! Realm().write() {
            try! Realm().add(obj, update: true)
            
        }
    }
}