//
//  SignUpViewController.swift
//  fastis
//
//  Created by Michael Brewington on 2/8/20.
//  Copyright © 2020 Michael Brewington. All rights reserved.
//

import UIKit
import Foundation
import Firebase

struct defaultsKeys {
    static var nameText = ""
    static var emailText = ""
    static var passwordText = ""
}
    
class SignUpViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        let settings = db.settings
        //settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        PageControl.transform = CGAffineTransform(scaleX: 2, y: 2)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
            
        leftSwipe.direction = .left
        rightSwipe.direction = .right

        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        //setupSlideScrollView(slides: slides)
        // Do any additional setup after loading the view.
        PageControl.numberOfPages = prompts.count
        PageControl.currentPage = 0
        view.bringSubviewToFront(PageControl)
    }
    
    var prompts = ["Let's start with your name:","Now your email please:","Now your password please:","You are now able to login"]
    var entry = ["","","",""]
    
    override func viewDidLayoutSubviews() {
        PageControl.subviews.forEach {
            $0.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }
    }
    
    var handle: AuthStateDidChangeListenerHandle?
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
        }
        //   self.dataLabel!.text = dataObject
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // [START remove_auth_listener]
        Auth.auth().removeStateDidChangeListener(handle!)
        // [END remove_auth_listener]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Auth.auth().currentUser != nil{
            //self.performSegue(withIdentifier: "SignupToProfileSegue", sender: self)
        }
    }
    
    @IBOutlet weak var PageControl: UIPageControl!
    @IBOutlet weak var GuideText: UILabel!
    @IBOutlet weak var LoginTextfield: UITextField!
    @IBOutlet weak var NextButton: UIButton!
    @IBAction func NextButtonAction(_ sender: UIButton) {
        buttonSwipe()
        if(PageControl.currentPage==3)
        {
            performSegue(withIdentifier: "SignupToHome", sender: self)
        }
    }

    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
            
        if (sender.direction == .left) {
                print("Swipe Left")
            trackIndex(bool: true)
        }
            
        if (sender.direction == .right) {
            print("Swipe Right")
             trackIndex(bool: false)
        }
    }
    
    func trackIndex(bool: Bool)
    {
        
        if(bool)
        {
            if(PageControl.currentPage==3)
            {
            }else
            {
                PageControl.currentPage = PageControl.currentPage + 1
                save(bool: bool)
            }
        } else
        {
            PageControl.currentPage = PageControl.currentPage - 1
            save(bool: bool)
        }
       
        GuideText.text = prompts[PageControl.currentPage]
        
        if(PageControl.currentPage==3)
        {
            LoginTextfield.isHidden = true
        } else
        {
            LoginTextfield.isHidden = false
        }
      
    }
    
    func save(bool: Bool)
    {
        if(bool)
        {
                entry[PageControl.currentPage-1] = LoginTextfield.text!
                LoginTextfield.text! = entry[PageControl.currentPage]
        }
        else
        {
            if(PageControl.currentPage==0){
                LoginTextfield.text! = entry[PageControl.currentPage]
            } else {
                entry[PageControl.currentPage+1] = LoginTextfield.text!
                LoginTextfield.text! = entry[PageControl.currentPage]
            }
        }
        
        for i in 0...PageControl.numberOfPages-1{
            print("\(entry[i])___\(i)")
        }
        print(PageControl.currentPage)
     }
    
    func checkEntry()
    {
        if (!entry[0].isEmpty && !entry[1].isEmpty && !entry[2].isEmpty) {
            defaultsKeys.nameText = entry[0]
            defaultsKeys.emailText = entry[1]
            defaultsKeys.passwordText = entry[2]
        } else
        {
            print("Empty Sign Up String")
        }
    }
    
    func AddUser()
    {
        checkEntry()
        
        Auth.auth().createUser(withEmail: defaultsKeys.emailText, password: defaultsKeys.passwordText){ (authResult, error) in
                   
                   if error == nil && authResult != nil {
                       print("User logged in!")
                       //
                       let userId = Auth.auth().currentUser?.uid
                    
        let ref = self.db.collection("users").document("\(userId!)")
        
        ref.setData([
            "Name": "\(defaultsKeys.nameText)"
        ], merge: true) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
               // print("Document added with ID: \(self.ref!.documentID)")
            }
        }
                    
    } else {
                print("Error Logging in user: \(error!.localizedDescription)")
            }
        }
    }
    
    func buttonSwipe()
    {
        if(PageControl.currentPage==3)
        {
            //Check if entries are full
            //Save Data
            //Segue to Next Screen
            AddUser()
        }
        else
        {
            PageControl.currentPage = PageControl.currentPage + 1
            
        }
        //var nameText = ""
        //var emailText = ""
        //var passwordText = ""

        /*
        for i in 0...PageControl.numberOfPages-1{
            print(entry[i])
        }
 */
    }
    /*
    func uploadData(title: String, entry: String)
    {
         let userId = Auth.auth().currentUser?.uid
        //
                       let ref2 = self.db.collection("users").document("\(userId!)")
                       ref2.setData([
                           "\(title)": "\(entry)",
                       ], merge: true) { err in
                           if let err = err {
                               print("Error adding document: \(err)")
                           } else {
                               // print("Document added with ID: \(self.ref!.documentID)")
                           }
                       }
                   // ...
    }
    func download(){
          
          let userId = Auth.auth().currentUser?.uid
          
          let ref = self.db.collection("users").document("\(userId!)")
          
          //  let ref = db.collection("users").document("\(userId!)")
          
          ref.getDocument(source: .cache) { (document, error) in
              if let document = document {
                  
                  let latMax = document.get("counter") as! Int
                  print(latMax)
                  // self.AboutMeTextView.text = "\(latMax)"
              } else {
                  print("Document does not exist in cache")
              }
          }
          
      }
 */
    /*
    func AddUser()
    {
        Auth.auth().createUser(withEmail: self.LoginTextfield.text!, password: self.LoginTextfield.text!){ (authResult, error) in
                   
                   if error == nil && authResult != nil {
                       print("User logged in!")
                       //
                       let userId = Auth.auth().currentUser?.uid
                    
        let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("")
        
        ref.setData([
            "aboutMe": ""
        ], merge: true) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
               // print("Document added with ID: \(self.ref!.documentID)")
            }
        }
                    
    } else {
                print("Error Logging in user: \(error!.localizedDescription)")
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
 */
    
}
