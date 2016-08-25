//
//  CityModel.swift
//  Weather
//
//  Created by Mac on 8/22/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift


class CityModel: Object{
    dynamic var name = ""
    dynamic var descriptionValue = ""
    var temperature = List<TemperatureModel>()
    override static func primaryKey() -> String? {
        return "name"
    }
    
    static func addToDataBase(completion: () -> ()) {
        let arrayOfTemperature = List<TemperatureModel>()
        let json = JsonClass()
        json.parsJson {(objects) in
            if !objects.isEmpty {
                let city = objects[0].titleLong
                var count = objects.count
                if count > 5 {count = 4}
                for index in 0...count  {
                    let temperature = TemperatureModel()
                    temperature.image = objects[index].iconUrl
                    temperature.day = objects[index].dayValue
                    temperature.month = objects[index].monthValue
                    temperature.year = objects[index].yearValue
                    temperature.latitude = json.latitude
                    temperature.longitude = json.longitude
                    temperature.tempMax = objects[index].hight
                    temperature.tempMin = objects[index].low
                    temperature.shortDay = objects[index].weekdayShort
                    temperature.icon = objects[index].icon
                   
                    arrayOfTemperature.append(temperature)
                }
                let countCity = HelperCity.countByName(city)
                if countCity == 0 {
                    let cityData = CityModel()
                    cityData.name = city
                    cityData.temperature = arrayOfTemperature
                    HelperCity.addToDataBase(cityData)
                    dispatch_async(dispatch_get_main_queue(), {
                        completion()
                    })
                } else {
                    
                    let cityData = CityModel()
                    cityData.name = city
                    cityData.temperature = arrayOfTemperature
                    HelperCity.updateCity(cityData)
                    dispatch_async(dispatch_get_main_queue(), {
                        completion()
                    })
                }
            }
        }
    }
}
