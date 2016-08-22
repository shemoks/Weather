//
//  CollectionViewCell.swift
//  Weather
//
//  Created by Mac on 8/11/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var day = weather(weekdayShort: "", hight: "", low: "", titleLong: "", conditions: "", iconUrl: "", dayValue: 0, monthValue: 0, yearValue: 0)
    func setCell(someDay: weather) {
        self.day = someDay
        dateLabel.text = day.weekdayShort
        temperatureLabel.text = day.hight + " / " + day.low
        let imgURL: NSURL = NSURL(string: day.iconUrl)!
        let imgData: NSData = NSData(contentsOfURL: imgURL)!
        imageView.image = UIImage(data: imgData)
    }
}
