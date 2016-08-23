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
//    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
//        // 3
//        if status == .AuthorizedWhenInUse {
//           
//            // 4
//            locationManager.startUpdatingLocation()
//        }
//        if status == .Denied {
//           defaultCoord.lat = 51.508530
//           defaultCoord.long = -0.076132
//            UserLocation.setUserLocation(defaultCoord)
//            Cities.addToDataBase{
//            
//            
//            
//            }
//          // performSegueWithIdentifier("ShowMap", sender: self)
//        }
//        
//    }
// 
//    
//    // перегружаете метод и реализуете передачу параметров
//   
//    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        
//        self.locationManager.stopUpdatingLocation()
//        //        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
//        let locValue = locations.last
//        defaultCoord.lat = locValue!.coordinate.latitude
//        defaultCoord.long = locValue!.coordinate.longitude
//        UserLocation.setUserLocation(defaultCoord)
//        Cities.addToDataBase{
//        
//        }
//    }
   
    
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

//        let result = JsonClass()
//        result.parsJsonForLocation { [weak self] (objects) in
//
//            if objects.isEmpty {
//                    UserLocation.setUserLocation(self!.defaultCoord)
//                    UserLocation.getUserLocation()
//                    self!.viewWillAppear(false)
//                } else {
//                self?.dayWeather = objects
//
//                self?.collectionView?.reloadData()
//                
//            }
//    }

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

   