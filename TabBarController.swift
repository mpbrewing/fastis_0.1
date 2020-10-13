//
//  TabBarController.swift
//  fastis
//
//  Created by Michael Brewington on 3/17/20.
//  Copyright © 2020 Michael Brewington. All rights reserved.
//

import Foundation
import UIKit

class TabBarController : UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // tell our UITabBarController subclass to handle its own delegate methods
        self.delegate = self
    }

    // called whenever a tab button is tapped
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

       if let firstVC = viewController as? HomeViewController {
           firstVC.doSomeAction()
        }
        if let firstVC = viewController as? CalendarViewController {
           firstVC.doSomeAction()
        }
        if viewController is HomeViewController {
                   print("First tab")
            
        } else if viewController is CalendarViewController {
                   print("Second tab")
        }
    }

    // alternate method if you need the tab bar item
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // ...
    }
}
