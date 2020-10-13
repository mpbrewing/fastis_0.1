//
//  PickerViewClass.swift
//  fastis
//
//  Created by Michael Brewington on 3/19/20.
//  Copyright © 2020 Michael Brewington. All rights reserved.
//

import UIKit

class PickerViewClass: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return repeatData.count
    }
    /*
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    */
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //
        passPicker()
    }
    
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: repeatData[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
        return attributedString
    }
    
    override func awakeFromNib() {
    super.awakeFromNib()
        handleData()
        self.picker.delegate = self
        self.picker.dataSource = self
       
    }
    
    var repeatData: [String] = [String]()
    var notifData = [String:[Int]]()
    
    func passPicker()
    {
        let myDict = ["picker": repeatData[picker.selectedRow(inComponent: 0)]] as [String : Any]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "repeat"), object: myDict)
    }
    
    
    @IBOutlet weak var picker: UIPickerView!
    
    func handleData()
    {
         repeatData = ["Does not repeat", "Every day", "Every week", "Every month", "Every year"]
         
        let minutes = Array(0...60)
        let hours = Array(0...24)
        let days = Array(0...28)
        let weeks = Array(0...4)
        
        notifData = ["minutes":minutes,"hours":hours,"days":days,"weeks":weeks]
    }
    
}

