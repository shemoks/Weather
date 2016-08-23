//
//  JsonClass.swift
//  Weather
//
//  Created by Mac on 8/10/16.
//  Copyright © 2016 Mac. All rights reserved.
//
struct weather {
    var weekdayShort: String
    var hight: String
    var low: String
    var titleLong: String
    var conditions: String
    var iconUrl: String
    var dayValue: Int
    var monthValue: Int
    var yearValue: Int
    
}

import Foundation
import Alamofire
import SwiftyJSON


class JsonClass {
    var longitude: Double
    var latitude: Double
    //    var titleCity: String
    var userKey = "726267c57afefba9"
    init () {
        let dataForURL = UserLocation.getUserLocation()
        self.longitude = dataForURL.long
        self.latitude = dataForURL.lat
        //       self.titleCity = dataForURL.cityName
    }
    func concatURLForCity(key: String, long: Double, lat: Double) -> String {
        let url = "http://api.wunderground.com/api/" + userKey + "/forecast10day/q/" + String(lat) + "," + String(long) + ".json"
        return url
    }
    
    func parsJson(completion: ([weather]) -> ()){
        var arrayOfObjects: [weather] = []
        var objectWeather = weather(weekdayShort: "", hight: "", low: "", titleLong: "", conditions: "", iconUrl: "", dayValue: 0, monthValue: 0, yearValue: 0)
        if let stringURL = NSURL(string: self.concatURLForCity(userKey, long: self.longitude, lat: self.latitude)) {
            Alamofire.request(.GET, stringURL).validate()
                .responseJSON { response in
                    switch response.result {
                    case .Success:
                        print("Validation Successful")
                        if let value = response.result.value {
                            let json = JSON(value)
                            
                            for day in json["forecast"]["simpleforecast"]["forecastday"].arrayValue {
                                
                                let name = day["date"]["weekday_short"].stringValue
                                objectWeather.weekdayShort = name
                                let titleLong = day["date"]["tz_long"].stringValue
                                objectWeather.titleLong = titleLong
                                let dayValue = day["date"]["day"].intValue
                                objectWeather.dayValue = dayValue
                                let monthValue = day["date"]["month"].intValue
                                objectWeather.monthValue = monthValue
                                let yearValue = day["date"]["year"].intValue
                                objectWeather.yearValue = yearValue
                                let celsiusHigh = day["high"]["celsius"].stringValue
                                objectWeather.hight =  celsiusHigh + "°"
                                let celsiusLow = day["low"]["celsius"].stringValue
                                objectWeather.low =  celsiusLow + "°"
                                let conditions = day["conditions"].stringValue
                                objectWeather.conditions = conditions
                                let iconUrl = day["icon_url"].stringValue
                                objectWeather.iconUrl = iconUrl
                                arrayOfObjects.append(objectWeather)
                            }
                            dispatch_async(dispatch_get_main_queue(), {
                                completion(arrayOfObjects)
                            })
                        }
                    case .Failure(let error):
                        print(error)
                    }
            }
            
        }
    }
}
