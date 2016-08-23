//
//  TemperatureModel.swift
//  Weather
//
//  Created by Mac on 8/22/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift


class TemperatureModel: Object {
    var name: CityModel?
    dynamic var latitude: Double = 0.0
    dynamic var longitude: Double = 0.0
    dynamic var day: Int = 0
    dynamic var month: Int = 0
    dynamic var year: Int = 0
    dynamic var tempMax = ""
    dynamic var tempMin = ""
    dynamic var image = ""
    dynamic var shortDay = ""
}