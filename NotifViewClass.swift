//
//  NotifViewClass.swift
//  fastis
//
//  Created by Michael Brewington on 3/19/20.
//  Copyright © 2020 Michael Brewington. All rights reserved.
//

import UIKit

class NotifViewClass: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            return intArray.count
        } else if component == 1 {
            return 4
        } else {
            return 4
        }
        //notifData["day"]?.count
    }
    /*
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    */
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //
        /*
        if component == 1 {
            if row == 0 {
                intArray = minutes
                picker.reloadAllComponents()
            }
            if row == 1 {
                intArray = hours
                picker.reloadAllComponents()
            }
            if row == 2 {
                intArray = days
                picker.reloadAllComponents()
            }
            if row == 3 {
                intArray = weeks
                picker.reloadAllComponents()
            }
            
           
        } else {
            
        }
         */
        
        passPicker(array: intArray)
        
        switch (row,component) {
        case (0,1):
             intArray = minutes
             picker.reloadAllComponents()
        case (1,1):
             intArray = hours
             picker.reloadAllComponents()
        case (2,1):
            intArray = days
             picker.reloadAllComponents()
        case (3,1):
            intArray = weeks
             picker.reloadAllComponents()
        default:
            print(row,component)
        }
        
        picker.reloadAllComponents()
        
        passPicker(array: intArray)
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        if component == 0 {
            let attributedString = NSAttributedString(string: "\(intArray[row])", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
            return attributedString
        } else if component == 1 {
            
            let attributedString = NSAttributedString(string: periodData[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
            return attributedString
        } else{
            let attributedString = NSAttributedString(string: periodData[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
            return attributedString
        }
    }
    
    override func awakeFromNib() {
    super.awakeFromNib()
        handleData()
        intArray = minutes
        self.picker.delegate = self
        self.picker.dataSource = self
    }
    
    var repeatData: [String] = [String]()
    var notifData = [[Any]]()
    var periodData: [String] = [String]()
    var intArray: [Int] = [Int]()
    
    let minutes = Array(0...60)
    let hours = Array(0...24)
    let days = Array(0...28)
    let weeks = Array(0...4)
    
    @IBOutlet weak var picker: UIPickerView!
    
    
     
     func passPicker(array: [Int])
        {
            let one = picker.selectedRow(inComponent: 0)
            let two = picker.selectedRow(inComponent: 1)
            //let numbers = array[one]
            let text = periodData[two]
            
            if array.count >= one {
                let string = "\(one) \(text) before"
                let myDict = ["notif": string] as [String : Any]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notif"), object: myDict)
            }
         //   }
        }
     
     
    
    func handleData()
    {
         repeatData = ["Does not repeat", "Every day", "Every week", "Every month", "Every year"]
        
        notifData = [[minutes],[hours],[days],[weeks]]
        
        periodData = ["minutes","hours","days","weeks"]
    }
    
}
