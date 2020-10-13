//
//  TimeTableViewCell.swift
//  fastis
//
//  Created by Michael Brewington on 3/18/20.
//  Copyright © 2020 Michael Brewington. All rights reserved.
//

import Foundation
import UIKit

class TimeTableViewCell: UITableViewCell {
    override func awakeFromNib() {
    super.awakeFromNib()
    modifySlider()
    setupPan()
        //print(MinView.center.x)
        //print(MaxView.center.x)
        colorEnds(view: MinView)
        colorEnds(view: MaxView)
        appendToClass()
        handleTime()
        //23.0
        //351.0
        viewBackground.backgroundColor = UIColor(red: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1)
    }
    
    var TimeList = [TimeClass]()
    
    func setupPan()
    {
        self.MinView.addGestureRecognizer(recognizer)
        self.MaxView.addGestureRecognizer(recognizer)
    }
    
    var recognizer: UIPanGestureRecognizer {
        get {
            return UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        }
    }
    
    func colorEnds(view: UIView)
    {
        let value = view.center.x
        
        switch value {
        case 28.0:
            view.backgroundColor = UIColor.systemIndigo
        case 380.0:
            view.backgroundColor = UIColor.systemIndigo
        default:
            view.backgroundColor = UIColor.systemGreen
        }
    }
    
    var list: [CGFloat] = []
    let timeList: [Int] = [12,1,2,3,4,5,6,7,8,9,10,11,12,1,2,3,4,5,6,7,8,9,10,11,12]
    let timeList2: [Int] = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24]
    //Function to divide slider width into 24 hours
    func handleTime()
    {
        for i in 0...24
        {
           let value = ((380.0-28.0) * (Double(i)/24.0))
           let newvalue = value + 28.0
           let myFloat = NSNumber.init(value: newvalue).floatValue
           let myCGFloat = CGFloat(myFloat)
          
        list.append(myCGFloat)
        }
    }
    
    //Function to assign hour based on distance from hour
    func handleToggle(input: CGFloat)
    {
        switch input {
        case MinView.center.x:
            handleDistance(input: input, index: 0)
        case MaxView.center.x:
            handleDistance(input: input, index: 1)
        default:
            print(input)
        }
        
    }
    
    func handleDistance(input: CGFloat,index: Int)
    {
        for i in 0...24 {
            let distance = abs(input - list[i])
                       
                if distance < 7.0{
                    let input = list[i]
                    
                    updateMinMax(update: timeList2[i], i: index)
            }
        }
    }
    
    //Function To Append Min and Max to TimeClass
    func appendToClass()
    {
        for _ in 0...1 {
        let time = TimeClass(time: 12)
        TimeList.append(time)
        }
    }
    //Function to update Min and Max
    func updateMinMax(update: Int,i:Int)
    {
        TimeList[i].changeTime(time: update)
        //print(TimeList[i].time)
    }
    //Function to pass Min and Max to Table View
    func passMinMax()
    {
        let myDict = ["min": TimeList[0].time, "max":TimeList[1].time] as [String : Any]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "time"), object: myDict)
    }
    
    @IBOutlet weak var viewFill: UIView!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var MinView: UIView!
    @IBOutlet weak var MaxView: UIView!
    
    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer)
    {
        switch gestureRecognizer.state {
        case .began:
             //print(MinView.center.x)
             //print(MaxView.center.x)
             
            
            
            if((gestureRecognizer.view?.center.x)! == (MaxView.center.x) as CGFloat){
                 
                 if((gestureRecognizer.view?.center.x)! <= (MinView.center.x) as CGFloat){
                     gestureRecognizer.view?.center.x = MinView.center.x + 25
                 }
             }
            
            if((gestureRecognizer.view?.center.x)! == (MinView.center.x) as CGFloat){
                 if((gestureRecognizer.view?.center.x)! >= (MaxView.center.x) as CGFloat){
                     gestureRecognizer.view?.center.x = MaxView.center.x - 25
                 }
                
                colorEnds(view: MinView)
                colorEnds(view: MaxView)
                 
            }
        case .changed:
           // if self.contentView.frame.contains(gestureRecognizer.location(in: self.contentView)) {
                // Gesture started inside the pannable view. Do your thing.
           //Bump into each other
           //Color at ends
           // handleTime()
            
           if ((gestureRecognizer.view?.center.x)! < 28.0 as CGFloat){
                           gestureRecognizer.view?.center.x = 28.0
                       }
                           
            if((gestureRecognizer.view?.center.x)! > 380.0 as CGFloat){
                           gestureRecognizer.view?.center.x = 380.0
                       }
           
            if((gestureRecognizer.view?.center.x)! == (MaxView.center.x) as CGFloat){
                
                if((gestureRecognizer.view?.center.x)! <= (MinView.center.x) as CGFloat){
                    gestureRecognizer.view?.center.x = MinView.center.x + 25
                }
            }else if((gestureRecognizer.view?.center.x)! == (MinView.center.x) as CGFloat){
                if((gestureRecognizer.view?.center.x)! >= (MaxView.center.x) as CGFloat){
                    gestureRecognizer.view?.center.x = MaxView.center.x - 25
                }
                
           }
        
            
                let translation = gestureRecognizer.translation(in: contentView)
                
                let direction = gestureRecognizer.direction(in: contentView)
                
                if direction.contains(.Left){
                   // print("Left")
                    
                    gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x + translation.x, y: gestureRecognizer.view!.center.y)
                     
                    gestureRecognizer.setTranslation(.zero, in: contentView)
                   // print(gestureRecognizer.view!.center.x)
                    
                } else if direction.contains(.Right)
                {
                    //print("Right")
                    
                    gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x + translation.x, y: gestureRecognizer.view!.center.y)
                     
                    gestureRecognizer.setTranslation(.zero, in: contentView)
                   // print(gestureRecognizer.view!.center.x)
                }
                colorEnds(view: MinView)
                colorEnds(view: MaxView)
            
            handleToggle(input: (gestureRecognizer.view?.center.x)!)
             passMinMax()
           // }
        case .ended,.cancelled:
          //  print("done")
            if ((gestureRecognizer.view?.center.x)! < 28.0 as CGFloat){
                gestureRecognizer.view?.center.x = 28.0
            }
                
            if((gestureRecognizer.view?.center.x)! > 380.0 as CGFloat){
                gestureRecognizer.view?.center.x = 380.0
            }
            
            if((gestureRecognizer.view?.center.x)! == (MaxView.center.x) as CGFloat){
                 
                 if((gestureRecognizer.view?.center.x)! <= (MinView.center.x) as CGFloat){
                     gestureRecognizer.view?.center.x = MinView.center.x + 25
                 }
             } else if((gestureRecognizer.view?.center.x)! == (MinView.center.x) as CGFloat){
                 if((gestureRecognizer.view?.center.x)! >= (MaxView.center.x) as CGFloat){
                     gestureRecognizer.view?.center.x = MaxView.center.x - 25
                 }
                 
            }
            
           handleToggle(input: (gestureRecognizer.view?.center.x)!)
         
            colorEnds(view: MinView)
            colorEnds(view: MaxView)
            
            passMinMax()
        default:
            //print(gestureRecognizer.state)
          
            colorEnds(view: MinView)
            colorEnds(view: MaxView)
        }
    }
    
    func modifySlider()
    {
        viewFill.layer.cornerRadius = 20
        viewBackground.layer.cornerRadius = 20
        MinView.layer.cornerRadius = 20
        MaxView.layer.cornerRadius = 20
    }
}

extension UIPanGestureRecognizer {

    public struct PanGestureDirection: OptionSet {
        public let rawValue: UInt8

        public init(rawValue: UInt8) {
            self.rawValue = rawValue
        }

        static let Up = PanGestureDirection(rawValue: 1 << 0)
        static let Down = PanGestureDirection(rawValue: 1 << 1)
        static let Left = PanGestureDirection(rawValue: 1 << 2)
        static let Right = PanGestureDirection(rawValue: 1 << 3)
    }

    private func getDirectionBy(velocity: CGFloat, greater: PanGestureDirection, lower: PanGestureDirection) -> PanGestureDirection {
        if velocity == 0 {
            return []
        }
        return velocity > 0 ? greater : lower
    }

    public func direction(in view: UIView) -> PanGestureDirection {
        let velocity = self.velocity(in: view)
        let yDirection = getDirectionBy(velocity: velocity.y, greater: PanGestureDirection.Down, lower: PanGestureDirection.Up)
        let xDirection = getDirectionBy(velocity: velocity.x, greater: PanGestureDirection.Right, lower: PanGestureDirection.Left)
        return xDirection.union(yDirection)
    }
}
