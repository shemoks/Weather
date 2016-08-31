//
//  ConteinerView.swift
//  Weather
//
//  Created by Mac on 8/19/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import Foundation
import UIKit
class ConteinerView: UIViewController {
    
    
    @IBAction func showTable(sender: AnyObject) {
        
        //     performSegueWithIdentifier("showTable", sender: self)
        
    }
    @IBAction func refreshPages() {
        let cities = HelperCity.getAllCity()
        embeddedPageController.arrayData = cities
        embeddedPageController.refresh()
    }
    
    @IBOutlet weak var conteiner: UIView!
    var embeddedPageController: PageViewController!
    var tableViewController: TableViewController!
    var viewController: ViewController!
    
    @IBAction func removeCurrectPage(sender: AnyObject) {
        embeddedPageController.removeView()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? PageViewController
            where segue.identifier == "toPageViewController" {
            self.embeddedPageController = vc
        }
        if let vc = segue.destinationViewController as? TableViewController
            where segue.identifier == "showTable" {
            self.tableViewController = vc
            let arrayCity = HelperCity.getAllCity()
            self.tableViewController.arrayCity = arrayCity
        }
    }
}
