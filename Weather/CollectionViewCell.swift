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
    func setCell(someDay: TemperatureModel) {
        dateLabel.text = someDay.shortDay
        temperatureLabel.text = someDay.tempMax + " / " + someDay.tempMin
        let imgURL: NSURL = NSURL(string: someDay.image)!
        let imgData: NSData = NSData(contentsOfURL: imgURL)!
        imageView.image = UIImage(data: imgData)
    }
}
