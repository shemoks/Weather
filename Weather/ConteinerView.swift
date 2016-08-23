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
    
    @IBOutlet weak var conteiner: UIView!
    var embeddedPageController: PageViewController!
    
    @IBAction func removePage(sender: AnyObject) {
        embeddedPageController.removeView(embeddedPageController)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? PageViewController
            where segue.identifier == "toPageViewController" {
            self.embeddedPageController = vc
        }
    }
}
