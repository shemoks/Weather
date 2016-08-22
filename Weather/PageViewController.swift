//
//  PageViewController.swift
//  Weather
//
//  Created by Mac on 8/12/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import UIKit
import RealmSwift
import CoreLocation

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var arrayData: [[weather]] = []
    var defaultCoord = location(long: 0, lat: 0)
    var count = 0
    var orderedViewControllers: [UIViewController] = []
    var controllers: [UIViewController] = []
    var pageViewController : UIPageViewController!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLocation ()
        
    }
    
    func getLocation(){
        
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        // 3
        if status == .AuthorizedWhenInUse {
            
            // 4
            self.locationManager.startUpdatingLocation()
        }
        if status == .Denied {
            defaultCoord.lat = 51.508530
            defaultCoord.long = -0.076132
            UserLocation.setUserLocation(defaultCoord)
            Cities.addToDataBase{
                self.dataForViewController { object in
                    self.sourceForView()
                }
                
            }
            // performSegueWithIdentifier("ShowMap", sender: self)
        }
        
    }
    
    
    // перегружаете метод и реализуете передачу параметров
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.locationManager.stopUpdatingLocation()
        //        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        let locValue = locations.last
        defaultCoord.lat = locValue!.coordinate.latitude
        defaultCoord.long = locValue!.coordinate.longitude
        UserLocation.setUserLocation(defaultCoord)
        Cities.addToDataBase{
            self.dataForViewController { object in
                self.sourceForView()
            }
            
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
        self.dataForViewController { object in
            self.orderedViewControllers = []
            self.controllers = []
            self.count = object.count
            if self.count > 0 {
                for i in 0...self.count - 1 {
                    let newViewController = ViewController()
                    newViewController.pageIndex = i
                    self.controllers.append(newViewController)
                    let controller = self.getViewControllerAtIndex(i)
                    self.orderedViewControllers.append(controller)
                    
                }
                self.sourceForViewNext()
            }
            
        }
        
        
    }
    
    func sourceForView() {
        
        dataSource = self
        self.setViewControllers( [getViewControllerAtIndex(0)] as [UIViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .Forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    func sourceForViewNext() {
        
        var firstElement: [UIViewController] = []
        firstElement.append(orderedViewControllers[0])
        
        
        self.setViewControllers( firstElement as [UIViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        
    }
    
    
    
    func dataForViewController (getData: ([[weather]]) -> ()) {
        arrayData = []
        let realm = try! Realm()
        let cities = realm.objects(Cities.self)
        let arrayOfCities = Array(cities)
        for city in arrayOfCities {
            let cityName = city.name
            let temperatureArray = Temperature()
            let queryTemp = temperatureArray.getTemperature(cityName)
            arrayData.append(queryTemp)
        }
        dispatch_async(dispatch_get_main_queue(), {
            getData(self.arrayData)
        })
    }
 

    
    func getViewControllerAtIndex(index: NSInteger) -> ViewController
    {
        // Create a new view controller and pass suitable data.
        let ViewControllers = self.storyboard?.instantiateViewControllerWithIdentifier("WeatherViewController") as! ViewController
        
        ViewControllers.dayWeather = arrayData[index]
        
        
        return ViewControllers
    }
    
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
    {
        if let viewControllerIndex = orderedViewControllers.indexOf(viewController) {
            
            if  viewControllerIndex - 1 >= 0   {
                return orderedViewControllers[viewControllerIndex - 1]
            }
        }
        return nil
    }
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
    {
        if let viewControllerIndex = orderedViewControllers.indexOf(viewController) {
            
            if  viewControllerIndex + 1 <  orderedViewControllers.count   {
                return orderedViewControllers[viewControllerIndex + 1]
            }
        }
        return nil
    }
    
    func removeView(pageViewController: UIPageViewController) {
        if let firstViewController = viewControllers?.first {
            let firstViewControllerIndex = orderedViewControllers.indexOf(firstViewController)
            if  firstViewControllerIndex > 0 { let arrayOfStruct = arrayData[firstViewControllerIndex!]
            for desidedStruct in arrayOfStruct {
            let cityName = desidedStruct.titleLong
                Temperature().deleteFromDataBase(cityName)
                break
            }
            }
            
        }
        
        self.dataForViewController { object in
            self.orderedViewControllers = []
            self.controllers = []
            self.count = object.count
            if self.count > 0 {
                for i in 0...self.count - 1 {
                    let newViewController = ViewController()
                    newViewController.pageIndex = i
                    self.controllers.append(newViewController)
                    let controller = self.getViewControllerAtIndex(i)
                    self.orderedViewControllers.append(controller)
                    
                }
                self.sourceForViewNext()
            }
            
        }
    }
   
    
}