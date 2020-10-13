//
//  Navigation.swift
//  fastis
//
//  Created by Michael Brewington on 3/14/20.
//  Copyright © 2020 Michael Brewington. All rights reserved.
//

import UIKit

class Navigation: UIView {
    
    @IBOutlet var ViewHandle: UIView!
    @IBOutlet weak var SearchBox: UIButton!
    @IBOutlet weak var profile: UIButton!
    
 override init(frame: CGRect) {
     super.init(frame: frame)
     xibSetup()
 }

 required init?(coder aDecoder: NSCoder) {
     super.init(coder: aDecoder)
     xibSetup()
 }

 func xibSetup() {
     ViewHandle = loadViewFromNib()

     // use bounds not frame or it'll be offset
     ViewHandle!.frame = bounds

     // Make the view stretch with containing view
    ViewHandle!.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]

     // Adding custom subview on top of our view (over any custom drawing > see note below)
     addSubview(ViewHandle!)
    
    handleButtons()
    
 }
    
    @IBAction func ProfileClick(sender: UIButton) {
         print("Profile Button")
        let vc = findViewController()
        if vc != nil {
           // vc?.performSegue(withIdentifier: "HomeToFiles", sender: self)
        }
    }
    @IBAction func SettingsClick(sender: UIButton) {
         print("Settings Button")
        let vc = findViewController()
        if vc != nil {
            vc?.performSegue(withIdentifier: "HomeToSignout", sender: self)
        }
    }
    
func handleButtons()
{
    profile.layer.cornerRadius = 22
    SearchBox.layer.cornerRadius = 20
}

 func loadViewFromNib() -> UIView! {

    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: "NavigationView", bundle: bundle)
    let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView

     return view
 }

}
