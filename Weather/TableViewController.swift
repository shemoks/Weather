//
//  TableViewController.swift
//  Weather
//
//  Created by Mac on 8/23/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var arrayCity: [CityModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        //        tableView.registerNib(nib, forCellReuseIdentifier: "CustomCellOne")
        self.tableView.registerNib(UINib(nibName: "CityCell", bundle: nil), forCellReuseIdentifier: "CityCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayCity.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CityCell", forIndexPath: indexPath) as? CityCell
        cell!.nameLabel.text = arrayCity[indexPath.row].name
        cell!.temperatureLabel.text = arrayCity[indexPath.row].temperature[0].tempMax + "/" + arrayCity[indexPath.row].temperature[0].tempMin
        let imgURL: NSURL = NSURL(string: arrayCity[indexPath.row].temperature[0].image)!
        let imgData: NSData = NSData(contentsOfURL: imgURL)!
        cell!.temperatureImage.image =  UIImage(data: imgData)
        
        
        
        
        return cell!
    }
    
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let index = indexPath.row
            if index > 0 {
                HelperCity.deleteObject(arrayCity[index])
                arrayCity = HelperCity.getAllCity()
                tableView.reloadData()
            }
        }
    }
    // Override to support rearranging the table view.

}
