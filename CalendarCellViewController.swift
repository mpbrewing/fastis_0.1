//
//  CalendarCellViewController.swift
//  fastis
//
//  Created by Michael Brewington on 3/10/20.
//  Copyright © 2020 Michael Brewington. All rights reserved.
//

import Foundation
import UIKit




class CalendarTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    override func awakeFromNib() {
           super.awakeFromNib()
           // Initialization code
           self.collectionView.dataSource = self
           self.collectionView.delegate = self
           self.collectionView.register(UINib.init(nibName: "CalendarCollectionCell", bundle: nil), forCellWithReuseIdentifier: "CalendarCollectionCell")
        setCalendar(date: Date())
           
       }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return weeks
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCollectionCell", for: indexPath) as! CalendarCollectionCell
        cell.DateLabel.text = "\(indexPath.row)"
        cell.configureCell(date: items[indexPath.section][indexPath.row])
        
        if CalDate.count > 0 {
            let components = (Calendar.current as NSCalendar).components([.month, .day,.weekday,.year], from: CalDate[0].date)
            let components2 = (Calendar.current as NSCalendar).components([.month, .day,.weekday,.year], from: items[indexPath.section][indexPath.row])
            
            if components2 == components {
                cell.setSwing(swing: "selected", date: items[indexPath.section][indexPath.row])
                cell.swing = "indigo"
            } else {
                cell.setSwing(swing: "none", date: items[indexPath.section][indexPath.row])
                cell.swing = ""
            }
            if CalDate.count > 1 {
            
                let components1 = (Calendar.current as NSCalendar).components([.month, .day,.weekday,.year], from: CalDate[1].date)
            if components2 == components1 {
                cell.setSwing(swing: "second", date: items[indexPath.section][indexPath.row])
                cell.swing = "blue"
            } else if components2 == components {
                cell.setSwing(swing: "selected", date: items[indexPath.section][indexPath.row])
                cell.swing = "indigo"
            } else {
                cell.setSwing(swing: "none", date: items[indexPath.section][indexPath.row])
                cell.swing = ""
            }
                
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 7.0, height: collectionView.frame.size.height / 5)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // print("Selected Cell: \(indexPath.row)")
        
        
        if let cell = collectionView.cellForItem(at: indexPath) as? CalendarCollectionCell {
            print("Selected Cell: \(indexPath.row)")
            //Save Text
            let ob = items[indexPath.section][indexPath.row]
            
            switch cell.swing {
            case "":
                if CalDate.count == 1 {
                    let cal = CalendarDate(date: ob, indexPath: indexPath)
                    
                    if CalDate[0].date < ob{
                        CalDate.append(cal)
                        cell.setSwing(swing: "second", date: ob)
                        cell.swing = "blue"
                    } else {
                        CalDate.insert(cal, at: 0)
                        cell.setSwing(swing: "selected", date: ob)
                        cell.swing = "indigo"
                        
                        let components = (Calendar.current as NSCalendar).components([.month, .day,.weekday,.year], from: CalDate[1].date)
                        let components2 = (Calendar.current as NSCalendar).components([.month, .day,.weekday,.year], from: items[indexPath.section][indexPath.row])
                        
                        if components.month == components2.month{
                        test(indexPath: CalDate[1].indexPath, guide: "blue")
                        }
                    }
                } else if CalDate.count == 0 {
                    let cal = CalendarDate(date: ob, indexPath: indexPath)
                    CalDate.append(cal)
                    cell.setSwing(swing: "selected", date: ob)
                    cell.swing = "indigo"
                } else {
                    
                }
            case "blue":
                CalDate.removeLast(1)
                cell.setSwing(swing: "none", date: ob)
                cell.swing = ""
            case "indigo":
                CalDate = CalDate.reversed()
                CalDate.removeLast(1)
                cell.setSwing(swing: "none", date: ob)
                cell.swing = ""
                if CalDate.count == 1 {
                    
                    let components = (Calendar.current as NSCalendar).components([.month, .day,.weekday,.year], from: CalDate[0].date)
                    let components2 = (Calendar.current as NSCalendar).components([.month, .day,.weekday,.year], from: items[indexPath.section][indexPath.row])
                    
                    if components.month == components2.month{
                     test(indexPath: CalDate[0].indexPath, guide: "indigo")
                    }
                }
            default:
                print(cell.swing)
            }
            
            passObj()
            
            }
    }
    
    func test(indexPath: IndexPath, guide: String)
    {
         if let cell = collectionView.cellForItem(at: indexPath) as? CalendarCollectionCell {
            let ob = items[indexPath.section][indexPath.row]
            
            switch (guide) {
            case "blue":
                cell.swing = "blue"
                cell.setSwing(swing: "second", date: ob)
            case "indigo":
                cell.swing = "indigo"
                cell.setSwing(swing: "selected", date: ob)
            default:
                cell.swing = ""
                cell.setSwing(swing: "none", date: ob)
            }
        }
    }
    
    var CalDate = [CalendarDate]()
    
    func checkMonth(indexPath: IndexPath, date: Date){
         if let cell = collectionView.cellForItem(at: indexPath) as? CalendarCollectionCell {
            let cal = Calendar.current
            let components = (cal as NSCalendar).components([.month, .day,.weekday,.year], from: date)
            let newMonth = components.month!
            if newMonth == month {
                test(indexPath: indexPath, guide: cell.swing)
            } else
            {
                test(indexPath: indexPath, guide: "none")
            }
        }
    }
    
    func passObj(){
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("EEE MMM d")
        
        switch CalDate.count {
        case 2:
            let indigoString = dateFormatter.string(from: CalDate[0].date)
            let blueString = dateFormatter.string(from: CalDate[1].date)
            let myDict = ["indigo": indigoString, "blue":blueString,"count":2] as [String : Any]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: myDict)
        case 1:
            let indigoString = dateFormatter.string(from: CalDate[0].date)
            let myDict = ["indigo": indigoString, "blue":"","count":1] as [String : Any]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: myDict)
        case 0:
            let myDict = ["indigo": "", "blue":"","count":0] as [String : Any]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: myDict)
        default:
            print(CalDate.count)
        }
    }
    
    func changeData(date: Date) -> String
    {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat="E-MMM-d"
        return dateFormatter.string(from: date)
    }


    @IBOutlet weak var MonthLabel: UILabel!
    @IBOutlet weak var LeftButton: UIButton!
    @IBOutlet weak var RightButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func LeftAction(_ sender: Any) {
        
            setCalendar(date: Date.from(year: year, month: (month-1), day: 1)!)
            print("Month:  \(month) and Year: \(year)")
            
            collectionView.reloadData()
        
       
            //let components = (Calendar.current as NSCalendar).components([.month, .day,.weekday,.year], from: CalDate[0].date)
            //let newMonth = components.month!

    }
    @IBAction func RightAction(_ sender: Any) {
        
                setCalendar(date: Date.from(year: year, month: (month+1), day: 1)!)
                print("Month:  \(month) and Year: \(year)")
        
                collectionView.reloadData()
        
       
    }
    
    var day = 0
    var weeks = 0
    var totalDaysInMonth = 0
    var month = 0
    var year = 0
    var items = [[Date]]()
    lazy var dateFormatter: DateFormatter = {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var totalCount = 0
    

    func setCalendar(date: Date) {
            let cal = Calendar.current
            let components = (cal as NSCalendar).components([.month, .day,.weekday,.year], from: date)
            day = components.day!
            year =  components.year!
            month = components.month!
            let months = dateFormatter.monthSymbols
            let monthSymbol = (months![month-1])
            //MonthLabel.text = "\(monthSymbol) \(year!)"
            MonthLabel.text = "\(monthSymbol)"

            let weekRange = (cal as NSCalendar).range(of: .weekOfMonth, in: .month, for: date)
            let dateRange = (cal as NSCalendar).range(of: .day, in: .month, for: date)
            weeks = weekRange.length
            totalDaysInMonth = dateRange.length

            let totalMonthList = weeks * 7
            var dates = [Date]()
            var firstDate = dateFormatter.date(from: "\(year)-\(month)-1")!
            let componentsFromFirstDate = (cal as NSCalendar).components([.month, .day,.weekday,.year], from: firstDate)
            firstDate = (cal as NSCalendar).date(byAdding: [.day], value: -(componentsFromFirstDate.weekday!-1), to: firstDate, options: [])!

            for _ in 1 ... totalMonthList {
                dates.append(firstDate)
                firstDate = (cal as NSCalendar).date(byAdding: [.day], value: +1, to: firstDate, options: [])!
            }
            let maxCol = 7
            let maxRow = weeks
            items.removeAll(keepingCapacity: false)
            var i = 0
    //        print("-----------\(monthSymbol) \(year!)------------")
            for _ in 0..<maxRow {
                var colItems = [Date]()
                for _ in 0..<maxCol {
                    colItems.append(dates[i])
                    i += 1
                }
    //            print(colItems)
                items.append(colItems)
            }
    //        print("---------------------------")
        }
}

extension Date {

    /// Create a date from specified parameters
    ///
    /// - Parameters:
    ///   - year: The desired year
    ///   - month: The desired month
    ///   - day: The desired day
    /// - Returns: A `Date` object
    static func from(year: Int, month: Int, day: Int) -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        return calendar.date(from: dateComponents) ?? nil
    }
}

class CalendarCollectionCell: UICollectionViewCell{
    var date: Date!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var Image: UIImageView!
    var swing = ""
    
    func setSwing(swing: String,date:Date){
        switch swing {
        case "selected":
            Image.backgroundColor = UIColor.systemIndigo
            DateLabel.textColor = UIColor.white
        case "second":
            Image.backgroundColor = UIColor.systemBlue
            DateLabel.textColor = UIColor.white
        case "none":
            Image.backgroundColor = UIColor.white
           configureCell(date: date)
        default:
            Image.backgroundColor = UIColor.white
            configureCell(date: date)
        }
    }
    
    func configureHidden(date:Date, date1:Date, month:Int)
    {
        let components = (Calendar.current as NSCalendar).components([.month, .day,.weekday,.year], from: date)
        let newMonth = components.month!
        //let components1 = (Calendar.current as NSCalendar).components([.month, .day,.weekday,.year], from: date1)
        //let newMonth1 = components1.month!
        //let components2 = (Calendar.current as NSCalendar).components([.month, .day,.weekday,.year], from: date2)
        //let newMonth2 = components2.month!
        
        if newMonth == month {
            if date == date1 {
              setSwing(swing: "selected", date: date)
            }
        } else {
             setSwing(swing: "none", date: date)
        }
    }
    
    func configureCell(date: Date){ //Adding Date
        Image.layer.cornerRadius = 20
        let cal = Calendar.current
        let components = (cal as NSCalendar).components([.day], from: date)
        let day = components.day!
        let componentsCurrent = (cal as NSCalendar).components([.month, .day,.weekday,.year], from: Date())
        let componentsNew = (cal as NSCalendar).components([.month, .day,.weekday,.year], from: date)
        //let dayCurrent =  componentsCurrent.day!
        if componentsNew == componentsCurrent{
            DateLabel.textColor = .systemGreen
        } else if Date()<date{
            DateLabel.textColor = .lightGray
        } else {
            DateLabel.textColor=UIColor.opaqueSeparator
        }
        self.DateLabel.text = "\(String(describing: day))"
    }
}
