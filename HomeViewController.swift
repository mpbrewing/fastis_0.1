//
//  HomeViewController.swift
//  fastis
//
//  Created by Michael Brewington on 3/13/20.
//  Copyright © 2020 Michael Brewington. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    @IBOutlet weak var ButtonView: AddButtonView!
    
    func doSomeAction()
    {
        ButtonView.toggleTab()
    }
    
}


