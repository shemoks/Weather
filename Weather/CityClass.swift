//
//  CityClass.swift
//  Weather
//
//  Created by Mac on 8/15/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class Cities: Object {
    
    dynamic var name = ""
    dynamic var descriptionValue = ""
  //  var temperature = List<Temperature>()
    
    
    func citiesCount() -> Int {
        
        let realm = try! Realm()
        let cities = realm.objects(Cities.self)
        let arrayOfCities = Array(cities)
        return arrayOfCities.count
    }
    
   
    
    static func addToDataBase(completion: () -> ()) {
        let json = JsonClass()
        json.parsJsonForLocation {(objects) in
            if !objects.isEmpty {
                let city = objects[0].titleLong
                var realm = try! Realm()
                let queryCity = realm.objects(Cities.self).filter("name = '\(city)'")
                let count = queryCity.count
                if count == 0 {
                    let cityData = Cities()
                    try! realm.write {
                        cityData.name = city
                        realm.add(cityData)
                        var count = objects.count
                        if count > 5 {count = 4}
                        for index in 0...count  {
                            let temperature = Temperature()
                            temperature.image = objects[index].iconUrl
                            temperature.day = objects[index].dayValue
                            temperature.month = objects[index].monthValue
                            temperature.year = objects[index].yearValue
                            temperature.latitude = json.latitude
                            temperature.longitude = json.longitude
                            temperature.name = objects[index].titleLong
                            temperature.tempMax = objects[index].hight
                            temperature.tempMin = objects[index].low
                            temperature.shortDay = objects[index].weekdayShort
                            realm.add(temperature)
                            
                        }
                        
                        dispatch_async(dispatch_get_main_queue(), {
                            completion()
                        })
                    }
                } else {
                    realm = try! Realm()
                    let queryTemp = realm.objects(Temperature.self).filter("name = '\(city)'")
                    try! realm.write {
                        realm.delete(queryTemp)
                        var count = objects.count
                        if count > 5 {count = 4}
                        for index in 0...count  {
                            let temperature = Temperature()
                            temperature.image = objects[index].iconUrl
                            temperature.day = objects[index].dayValue
                            temperature.month = objects[index].monthValue
                            temperature.year = objects[index].yearValue
                            temperature.latitude = json.latitude
                            temperature.longitude = json.longitude
                            temperature.name = objects[index].titleLong
                            temperature.tempMax = objects[index].hight
                            temperature.tempMin = objects[index].low
                            temperature.shortDay = objects[index].weekdayShort
                            
                            realm.add(temperature)
                            
                        }
                        
                        dispatch_async(dispatch_get_main_queue(), {
                            completion()
                        })
                    }
                }
            }
        }
       
//        dispatch_async(dispatch_get_main_queue(), {
//            completion()
//        })
    }
    
//    func getObjectTemp (nameCity: String) -> Results<Temperature> {
//        let realm = try! Realm()
//        let queryTemperature = realm.objects(Temperature.self).filter("name = '\(nameCity)'")
//        self.temperature = queryTemperature
//        return self.temperature
//    }

}

