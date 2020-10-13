//
//  AddButtonController.swift
//  fastis
//
//  Created by Michael Brewington on 3/16/20.
//  Copyright © 2020 Michael Brewington. All rights reserved.
//

import UIKit

class AddButtonView: UIView {
    
    @IBOutlet weak var ViewHandle: UIView!

    @IBOutlet weak var AddButton: UIButton!
    @IBOutlet weak var FileButton: UIButton!
    @IBOutlet weak var FolderButton: UIButton!
    
    var state = "plus"
    
    
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
    
    func handleButtons()
    {
        AddButton.layer.cornerRadius = 35
        changeLayer(button: FileButton)
        changeLayer(button: FolderButton)
        toggleAdd()
    }
    
    func toggleAdd()
    {
        switch state {
        case "plus":
            //print("plus")
            AddButton.setImage(UIImage(named: "plus"), for: .normal)
            FileButton.isHidden = true
            FolderButton.isHidden = true
            state = "cancel"
            break
        case "cancel":
            //print("cancel")
            AddButton.setImage(UIImage(named: "cancel"), for: .normal)
            FileButton.isHidden = false
            FolderButton.isHidden = false
            state = "plus"
            break
        default:
            print("default")
        }
    }

    func toggleTab()
    {
        switch state {
        case "plus":
            toggleAdd()
        case "cancel":
            print("cancel")
        default:
            print("default")
        }
    }
    
    @IBAction func ActionClick(sender: UIButton) {
        print("Add Button")
        toggleAdd()
    }
    
    @IBAction func FileClick(sender: UIButton) {
        print("File Button")
        let vc = findViewController()
        if vc != nil {
            vc?.performSegue(withIdentifier: "HomeToFiles", sender: self)
            toggleAdd()
        }
    }
    @IBAction func FolderClick(sender: UIButton) {
         print("Folder Button")
        let vc = findViewController()
        if vc != nil {
            vc?.performSegue(withIdentifier: "HomeToFolder", sender: self)
            toggleAdd()
        }
    }
    
    func changeLayer(button: UIButton)
    {
        button.layer.borderWidth = 2.0
        button.layer.borderColor = UIColor(red: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1).cgColor
        button.layer.cornerRadius = 30.0
        button.clipsToBounds = true
    }
    
    func loadViewFromNib() -> UIView! {

        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "AddButtons", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView

         return view
     }
}

extension UIView {
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}
