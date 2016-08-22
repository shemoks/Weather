//
//  Temperature.swift
//  Weather
//
//  Created by Mac on 8/16/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class Temperature: Object {
    
    
    dynamic var name = ""
    var latitude: Double = 0.0
    dynamic var longitude: Double = 0.0
    dynamic var day: Int = 0
    dynamic var month: Int = 0
    dynamic var year: Int = 0
    dynamic var tempMax = ""
    dynamic var tempMin = ""
    dynamic var image = ""
    dynamic var shortDay = ""
    
    func getTemperature(nameCity: String) -> [weather] {
        var array: [weather] = []
        let realm = try! Realm()
        let queryTemperature = realm.objects(Temperature.self).filter("name = '\(nameCity)'")
        let arrayOfCities = Array(queryTemperature)
        var cityWeather = weather(weekdayShort: "", hight: "", low: "", titleLong: "", conditions: "", iconUrl: "", dayValue: 0, monthValue: 0, yearValue: 0)
        for temp in arrayOfCities {
        cityWeather.weekdayShort = temp.shortDay
        cityWeather.hight = temp.tempMax
        cityWeather.low = temp.tempMin
        cityWeather.titleLong = temp.name
        cityWeather.iconUrl = temp.image
       array.append(cityWeather)
        }
        return array
    }
    
    func deleteFromDataBase(cityName: String) {
        let realm = try! Realm()
        let cheeseCity = realm.objects(Cities.self).filter("name = '\(cityName)'")
        let cheeseTemperature = realm.objects(Temperature.self).filter("name = '\(cityName)'")
        try! realm.write {
            realm.delete(cheeseCity)
            realm.delete(cheeseTemperature)
        }
    
    }
   
    
}