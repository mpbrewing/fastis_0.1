//
//  LogInViewController.swift
//  fastis
//
//  Created by Michael Brewington on 2/8/20.
//  Copyright © 2020 Michael Brewington. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class LogInViewController: UIViewController {

    var dataObject: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LogInButton.layer.cornerRadius = 30
        beginText()
        
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            self.performSegue(withIdentifier: "LoginToMainSegue", sender: self)
        }
    }
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var PasswordLabel: UILabel!
    
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    

    @IBAction func EmailAction(_ sender: UITextField) {
        EmailLabel.alpha = 1
    }
    @IBAction func PasswordAction(_ sender: UITextField) {
        PasswordLabel.alpha = 1
    }
    
    @IBAction func EmailChange(_ sender: Any) {
        beginText()
    }
    
    @IBAction func PasswordChange(_ sender: Any) {
        beginText()
    }
    
    func beginText()
    {
        if(!EmailTextField.hasText)
        {
            EmailLabel.alpha = 0
        }
        if(EmailTextField.hasText)
        {
            EmailLabel.alpha = 1
        }
        if(!PasswordTextField.hasText)
        {
            PasswordLabel.alpha = 0
        }
        if(PasswordTextField.hasText) {
            PasswordLabel.alpha = 1
        }
    }
    
    @IBAction func ForgotPassword(_ sender: Any) {
        
    }
    
    
    @IBOutlet weak var LogInButton: UIButton!
    @IBAction func LogInAction(_ sender: UIButton) {
        print(self.EmailTextField.text!)
        print(self.PasswordTextField.text!)
        Auth.auth().signIn(withEmail: self.EmailTextField.text!, password: self.PasswordTextField.text!) { (authResult, error) in
              
              if error == nil && authResult != nil {
                  print("User logged in!")
                  if Auth.auth().currentUser != nil{
                      self.handle = Auth.auth().addStateDidChangeListener { (auth, user) in
                        self.performSegue(withIdentifier: "LoginToHome", sender: self)
                      }
                  }
              } else {
                  print("Error Logging in user: \(error!.localizedDescription)")
              }
              
              // ...
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

}
