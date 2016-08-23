//
//  ViewController.swift
//  Weather
//
//  Created by Mac on 8/9/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, CLLocationManagerDelegate {
    
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
        let imgURL: NSURL = NSURL(string: dayWeather.temperature[0].image)!
        let imgData: NSData = NSData(contentsOfURL: imgURL)!
        self.imageGeneral.image = UIImage(data: imgData)
        self.tempGeneral.text = dayWeather.temperature[0].tempMax
        self.city.text = dayWeather.name
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
}

   