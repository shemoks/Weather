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
    
    func parsJsonForLocation(completion: ([weather]) -> ()) {
        var arrayOfObjects: [weather] = []
        var objectWeather = weather(weekdayShort: "", hight: "", low: "", titleLong: "", conditions: "", iconUrl: "", dayValue: 0, monthValue: 0, yearValue: 0)
        let stringURL = NSURL(string: concatURLForCity(userKey, long: self.longitude, lat: self.latitude))
        let session = NSURLSession.sharedSession()
        let task = session.downloadTaskWithURL(stringURL!, completionHandler: {(location: NSURL?, response: NSURLResponse?, error: NSError?) -> Void
            in
            let weatherData = NSData(contentsOfURL: stringURL!)
            do {
                let weatherJson =  try NSJSONSerialization.JSONObjectWithData(weatherData!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                print(weatherJson)
                if let forecast = weatherJson["forecast"] as? [String: AnyObject] {
                   
                        if let simpleforecast = forecast["simpleforecast"] as? [String: AnyObject] {
                            if let forecastDay = simpleforecast["forecastday"] as? [[String: AnyObject]] {
                                for day in forecastDay {
                                    if let name = day["date"] as? [String: AnyObject] {
                                        if let weekdayShort = name["weekday_short"] as? String {
                                            objectWeather.weekdayShort = weekdayShort
                                        }
                                        if let titleLong = name["tz_long"] as? String {
                                            objectWeather.titleLong = titleLong
                                        }
                                        if let dayValue = name["day"] as? Int {
                                            objectWeather.dayValue = dayValue
                                        }
                                        
                                        if let monthValue = name["month"] as? Int {
                                            objectWeather.monthValue = monthValue
                                        }
                                        if let yearValue = name["year"] as? Int {
                                            objectWeather.yearValue = yearValue
                                        }

                                    }
                                    if let high = day["high"] as? [String: AnyObject] {
                                        if let celsiusHigh = high["celsius"] as? String {
                                            objectWeather.hight =  celsiusHigh + "°"
                                        }
                                    }
                                    if let low = day["low"] as? [String: AnyObject] {
                                        if let celsiusLow = low["celsius"] as? String {
                                            objectWeather.low = celsiusLow + "°"
                                        }
                                    }
                                    if let conditions = day["conditions"] as? String {
                                       objectWeather.conditions = conditions
                                    }
                                    if let iconUrl = day["icon_url"] as? String {
                                       objectWeather.iconUrl = iconUrl
                                    }
                                    arrayOfObjects.append(objectWeather)
                                    
                                }
                                
                            }
                            
                        }
                        
                }
                
                
            } catch {
                print(error)
            }
            dispatch_async(dispatch_get_main_queue(), { 
                completion(arrayOfObjects)
            })
        })
        
        task.resume()
    }
    

}
