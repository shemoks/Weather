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
    var temperature = List<Temperature>()
    
    override static func primaryKey() -> String? {
    
        return "name"
    
    }

   
}