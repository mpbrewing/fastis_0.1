//
//  AddFileViewController.swift
//  fastis
//
//  Created by Michael Brewington on 3/6/20.
//  Copyright © 2020 Michael Brewington. All rights reserved.
//
//let folder = Folders(titleText: name, photoURL: photoUrl, DocumentID: document.documentID)
//self.folderList.append(folder)
//print(self.folderList)
//self.tableView.reloadData()

import Foundation
import UIKit

class TitleCell: UITableViewCell{
    @IBOutlet weak var AddTitle: UITextField!
    
}

class DescriptionCell: UITableViewCell{
    @IBOutlet weak var AddDescription: UITextField!
    
}

class DateCell: UITableViewCell{
    @IBOutlet weak var AddImage: UIImageView!
    @IBOutlet weak var AddText: UILabel!
    let datelabel = UILabel()
    @IBOutlet weak var first: UILabel!
    @IBOutlet weak var second: UILabel!
    
    
}

class AddFileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var TabList = [AddFileTabs]()
    var SectionList = [Section]()
    var TabItems = [Tab]()
    let tableList = ["Title","Description","Date","Time","Repeat","Notification","Location","Tag","Importance","Status","Attachment"]
    let IconList = ["Title","Description","AddDate","AddTime","AddRepeat","AddNotification","AddLocation","AddTag","AddImportance","AddStatus","AddAttachments"]
    var testList = ["1","2"]
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.SectionList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SectionList[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch (section: indexPath.section,row: indexPath.row) {
        case (0,0):
            let cell = tableView.dequeueReusableCell(withIdentifier: "Title", for: indexPath) as! TitleCell
            cell.AddTitle.attributedPlaceholder = NSAttributedString(string: "| Enter Title...",
           attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1)])
            return cell
        case (1,0):
            let cell = tableView.dequeueReusableCell(withIdentifier: "Description", for: indexPath) as! DescriptionCell
            //| Enter Description...
            cell.AddDescription.attributedPlaceholder = NSAttributedString(string: "| Enter Description...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1)])
            return cell
        case (2...TabList.count,0):
            let cell = tableView.dequeueReusableCell(withIdentifier: "Add", for: indexPath) as! DateCell
            cell.AddImage.layer.cornerRadius = 15
            cell.AddText.text = "\(tableList[indexPath.section])"
            cell.AddImage.image = UIImage(named: IconList[indexPath.section])
            if(indexPath.section == 2){
                handleDateLabels(first: cell.first, second: cell.second, text: cell.AddText, row: 0)
            }
            if(indexPath.section == 3){
                handleDateLabels(first: cell.first, second: cell.second, text: cell.AddText, row: 1)
            }
            if(indexPath.section == 4){
                handleDateLabels(first: cell.first, second: cell.second, text: cell.AddText, row: 2)
            }
            if(indexPath.section == 5){
                handleDateLabels(first: cell.first, second: cell.second, text: cell.AddText, row: 3)
            }
            //
            return cell
        case (2,1):
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarView", for: indexPath) as! CalendarTableViewCell
            return cell
        case (3,1):
            let cell = tableView.dequeueReusableCell(withIdentifier: "TimeView", for: indexPath) as! TimeTableViewCell
            return cell
        case (4,1):
            //Repeat Picker
            let cell = tableView.dequeueReusableCell(withIdentifier: "PickerView", for: indexPath) as! PickerViewClass
            return cell
        case (5,1):
            let cell = tableView.dequeueReusableCell(withIdentifier: "Notif", for: indexPath) as! NotifViewClass
            return cell
        case (10,1):
            let cell = tableView.dequeueReusableCell(withIdentifier: "Description", for: indexPath) as! DescriptionCell
            cell.AddDescription.isHidden = true
            return cell
        default:
             let cell = tableView.dequeueReusableCell(withIdentifier: "Add", for: indexPath) as! DateCell
             cell.AddImage.layer.cornerRadius = 15
             return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         switch (section: indexPath.section,row: indexPath.row) {
            case(2,1):
                return 370
            case(3,1):
                return 100
            case(4,1):
                return 220
            case(5,1):
                return 220
            default:
                return 80
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         switch (section: indexPath.section,row: indexPath.row) {
            case (2,0):
                if(SectionList[2].count==1)
                {
                    let tab = AddFileTabs(cellKey: "CalendarView", cellSection: 2, cellRow: 1)
                    self.TabList.append(tab)
                    SectionList[2].changeRow(newCount: 2)
                    self.tableview.register(UINib(nibName: "CalendarCell", bundle:nil), forCellReuseIdentifier: "CalendarView")
                    self.tableview.reloadData()
                } else {
                    self.TabList.removeLast()
                    SectionList[2].changeRow(newCount: 1)
                    self.tableview.reloadData()
                }
         case(3,0):
            if(SectionList[3].count==1)
            {
                let tab = AddFileTabs(cellKey: "TimeView", cellSection: 3, cellRow: 1)
                self.TabList.append(tab)
                SectionList[3].changeRow(newCount: 2)
                
                self.tableview.register(UINib(nibName: "TimeCell", bundle:nil), forCellReuseIdentifier: "TimeView")
                self.tableview.reloadData()
            } else {
                self.TabList.removeLast()
                SectionList[3].changeRow(newCount: 1)
                self.tableview.reloadData()
            }
        case(4,0):
            //Repeat Picker
            if(SectionList[4].count==1)
            {
                let tab = AddFileTabs(cellKey: "PickerView", cellSection: 4, cellRow: 1)
                self.TabList.append(tab)
                SectionList[4].changeRow(newCount: 2)
                
                self.tableview.register(UINib(nibName: "PickerView", bundle:nil), forCellReuseIdentifier: "PickerView")
                self.tableview.reloadData()
            } else {
                self.TabList.removeLast()
                SectionList[4].changeRow(newCount: 1)
                self.tableview.reloadData()
            }
        case(5,0):
        //Notif Picker
            if(SectionList[5].count==1)
            {
                let tab = AddFileTabs(cellKey: "Notif", cellSection: 5, cellRow: 1)
                self.TabList.append(tab)
                SectionList[5].changeRow(newCount: 2)
                
                self.tableview.register(UINib(nibName: "NotifView", bundle:nil), forCellReuseIdentifier: "Notif")
                self.tableview.reloadData()
            } else {
                self.TabList.removeLast()
                SectionList[5].changeRow(newCount: 1)
                self.tableview.reloadData()
            }
        case(6,0):
                print("6")
                let vc = LocationCell(nibName: "LocationView", bundle: nil)
                navigationController?.pushViewController(vc, animated: true)
                tableView.deselectRow(at: indexPath, animated: true)
            default:
                 print("default")
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.backgroundColor = UIColor.white
        self.parent?.view.backgroundColor = UIColor.white
        self.hideKeyboardWhenTappedAround()
        returnSection()
        AddButton.layer.cornerRadius = 15
        appendToClass()
        SectionList[10].changeRow(newCount: 2)
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: .myNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadTime), name: .timeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadRepeat), name: .repeatNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadNotif), name: .notifNotification, object: nil)
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    var DateLabels = [DateLabel]()

    @objc func loadList(notification: NSNotification){

        let dict = notification.object as! NSDictionary
        
        let count = dict["count"] as! Int
        let indigo = dict["indigo"] as! String
        let blue = dict["blue"] as! String
        
        DateLabels[0].changeLabels(count: count, first: indigo, second: blue)
        self.tableview.reloadData()
    }
    
    func handleDateLabels(first:UILabel,second:UILabel,text:UILabel, row: Int)
    {
        switch DateLabels[row].count {
        case 0:
            first.isHidden = true
            second.isHidden = true
            text.isHidden = false
        case 1:
            first.isHidden = false
            second.isHidden = true
            text.isHidden = true
            makeButtons(count: 1, first: "\(DateLabels[row].first)", second: "\(DateLabels[row].second)", label: first, label2: second)
        case 2:
            first.isHidden = false
            second.isHidden = false
            text.isHidden = true
            makeButtons(count: 2, first: "\(DateLabels[row].first)", second: "\(DateLabels[row].second)", label: first, label2: second)
        default:
            first.isHidden = true
            second.isHidden = true
            text.isHidden = true
        }
    }
    
    let timeList: [Int] = [12,1,2,3,4,5,6,7,8,9,10,11,12,1,2,3,4,5,6,7,8,9,10,11,12]
    
    @objc func loadTime(notification: NSNotification){
        
        let dict = notification.object as! NSDictionary
        let min = dict["min"] as! Int
        let max = dict["max"] as! Int
        
        //DateLabels[1].changeLabels(count: 2, first: min, second: max)
        switch (min,max) {
        case (0...11,0...11):
            DateLabels[1].changeLabels(count: 2, first: "\(timeList[min]):00 am", second: "\(timeList[max]):00 am")
        case (12...23,12...23):
            DateLabels[1].changeLabels(count: 2, first: "\(timeList[min]):00 pm", second: "\(timeList[max]):00 pm")
        case (0...11,12...23):
            DateLabels[1].changeLabels(count: 2, first: "\(timeList[min]):00 am", second: "\(timeList[max]):00 pm")
        case (12...23,24):
            DateLabels[1].changeLabels(count: 2, first: "\(timeList[min]):00 pm", second: "\(timeList[max]):00 am")
        case (0...11,24):
            DateLabels[1].changeLabels(count: 2, first: "\(timeList[min]):00 am", second: "\(timeList[max]):00 am")
        default:
            print(min,max)
        }
        
        self.tableview.reloadData()
        
    }
    
    @objc func loadRepeat(notification: NSNotification){
        
        let dict = notification.object as! NSDictionary
        let picker = dict["picker"] as! String
        DateLabels[2].changeLabels(count: 1, first: picker, second: "")
        self.tableview.reloadData()
    }
    
    @objc func loadNotif(notification: NSNotification){
        
        let dict = notification.object as! NSDictionary
        let picker = dict["notif"] as! String
        DateLabels[3].changeLabels(count: 1, first: picker, second: "")
        self.tableview.reloadData()
    }
    
    //Location
    //Tags
    //Importance
    //Status
    //Atttachment
    
    //Function To Append Min and Max to TimeClass
    func appendToClass()
    {
       DateLabels = []
        for _ in 0...3 {
        let date = DateLabel(count: 0, first: "", second: "")
        DateLabels.append(date)
        }
    }
    

    func makeButtons(count:Int,first:String,second:String,label:UILabel,label2:UILabel)
    {
        switch count {
        case 1:
            label.text = "\(first)"
            label.textColor=UIColor.white
            label.font = UIFont(name: "Top Modern as created using Fon", size: 15)
            label.numberOfLines = 1
            label.textAlignment = .center
            label.sizeToFit()
            label.frame = CGRect(x: 90, y: 25, width: label.frame.width+10, height:label.frame.height+10)
            label.backgroundColor = UIColor.systemIndigo
            label.layer.cornerRadius = 5
            label.clipsToBounds = true
            //print(count)
        case 2:
            label.text = "\(first)"
            label.textColor=UIColor.white
            label.font = UIFont(name: "Top Modern as created using Fon", size: 15)
            label.numberOfLines = 1
            label.textAlignment = .center
            label.sizeToFit()
            label.frame = CGRect(x: 90, y: 25, width: label.frame.width+10, height:label.frame.height+10)
            label.backgroundColor = UIColor.systemIndigo
            label.layer.cornerRadius = 5
            label.clipsToBounds = true
            
            label2.text = "\(second)"
            label2.textColor=UIColor.white
            label2.font = UIFont(name: "Top Modern as created using Fon", size: 15)
            label2.numberOfLines = 1
            label2.textAlignment = .center
            label2.sizeToFit()
            label2.frame = CGRect(x:  label.frame.maxX+10, y: 25, width: label2.frame.width+10, height:label2.frame.height+10)
            label2.backgroundColor = UIColor.systemBlue
            label2.layer.cornerRadius = 5
            label2.clipsToBounds = true
           // print(count)
        default:
            print(count)
        }
    }
    
    @IBOutlet weak var AddButton: UIButton!
    @IBOutlet weak var tableview: UITableView!
    
    func returnSection()
    {
        SectionList = []
        for i in 0 ... (tableList.count-1)
        {
            let section = Section(cellRow: i, cellTitle: tableList[i], cellCount: 0)
            self.SectionList.append(section)
        }
         returnRow()
    }
    
    func returnRow()
    {
        for i in 0...(SectionList.count-1)
        {
            switch (i) {
            case 0:
                let tab = AddFileTabs(cellKey: "Title", cellSection: i, cellRow: 0)
                self.TabList.append(tab)
                SectionList[i].changeRow(newCount: 1)
                
            case 1:
                let tab = AddFileTabs(cellKey: "Description", cellSection: i, cellRow: 0)
                self.TabList.append(tab)
                SectionList[i].changeRow(newCount: 1)
                
            case 2...(SectionList.count-1):
                let tab = AddFileTabs(cellKey: "Add", cellSection: i, cellRow: 0)
                self.TabList.append(tab)
                SectionList[i].changeRow(newCount: 1)
            
            default:
                print(i)
            }
            print(TabList[i].key)
        }
    }
    
}
extension Notification.Name {
static let myNotification = Notification.Name("load")
static let timeNotification = Notification.Name("time")
static let repeatNotification = Notification.Name("repeat")
static let notifNotification = Notification.Name("notif")
    //Location
    //Tags
    //Importance
    //Status
    //Attachment
}

class DateLabel {
    var count: Int
    var first:  String
    var second: String
    
    init(count:Int,first:String,second:String){
        self.count = count
        self.first = first
        self.second = second
    }
    
    func changeLabels(count:Int,first:String,second:String)
    {
        self.count = count
        self.first = first
        self.second = second
    }
}
