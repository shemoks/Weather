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
    let queryCity = realm.objects(CityModel.self).filter("name = '\(cityName)'")
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
    
    static func deleteObject(obj: CityModel ) {
          try! Realm().write() {
            try! Realm().delete(obj)
        }
    }
    
    static func countByName(name: String) -> Int {
        let cheeseCity = try!Realm().objects(CityModel).filter("name = '\(name)'")
        let count = cheeseCity.count
        return count
    }
    
    static func updateCity(obj: CityModel ) {
        
        try! Realm().write() {
            try! Realm().add(obj, update: true)
            
        }
    }
}