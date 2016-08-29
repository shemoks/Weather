//
//  ViewController.swift
//  Weather
//
//  Created by Mac on 8/9/16.
//  Copyright © 2016 Mac. All rights reserved.
//
public enum PictureWeather: String {
case cloudy = "clody"
case clear = "clear"
case chancerain = "chancerain"
case chancetstorms = "chancetstorms"
    func picture() -> UIImage {
        var image: UIImage
        switch self {
        case .cloudy: image = UIImage(named: "cloudy.jpg")!
        case .clear: image = UIImage(named: "weather_3")!
        case .chancerain: image = UIImage(named: "rain.jpg")!
        case .chancetstorms: image = UIImage(named: "groza.jpg")!
       }
    return image
    }
}

import UIKit
import CoreLocation


class ViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var fonImage: UIImageView!
    @IBOutlet weak var dayWeek: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var tempGeneral: UILabel!
    @IBOutlet weak var imageGeneral: UIImageView!
    @IBOutlet weak var conditions: UILabel!
    @IBOutlet weak var collectionView: UICollectionView?
    var dayWeather = CityModel()
    var pageIndex: Int = 0
    var defaultCoord = location(long: 0, lat: 0)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 70, height: 150)
        collectionView!.dataSource = self
        collectionView!.delegate = self
        collectionView!.setCollectionViewLayout(layout, animated: false)
        self.dataView(dayWeather, indexDay: 0)
    }
   
    func dataView(dayWeather: CityModel, indexDay: Int) {
        let imgURL: NSURL = NSURL(string: dayWeather.temperature[indexDay].image)!
        let imgData: NSData = NSData(contentsOfURL: imgURL)!
        self.imageGeneral.image = UIImage(data: imgData)
        self.tempGeneral.text = dayWeather.temperature[indexDay].tempMax
        self.city.text = dayWeather.name
        let date: String = String(dayWeather.temperature[indexDay].day) + "." + String(dayWeather.temperature[indexDay].month) + "."  + String(dayWeather.temperature[indexDay].year)
        self.dayWeek.text = date
     
        UIView.transitionWithView(self.fonImage, duration: 0.325, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
            
            let pictureValue: PictureWeather.RawValue = dayWeather.temperature[indexDay].icon
            if  let value: PictureWeather = PictureWeather(rawValue: pictureValue) {
                self.fonImage.image = value.picture()
            } else {
                self.fonImage.image = UIImage(named: "weather_3")
            }
            
            }, completion: { (finished: Bool) -> () in
                
                // completion
                
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if dayWeather.temperature.count > 5 {
            return 5
        } else {
            return dayWeather.temperature.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! CollectionViewCell
        cell.setCell(dayWeather.temperature[indexPath.item])
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let index = indexPath.item
        dataView(self.dayWeather, indexDay: index)
        
    }
   
}

   