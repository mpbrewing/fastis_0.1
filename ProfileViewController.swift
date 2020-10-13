//
//  ProfileViewController.swift
//  fastis
//
//  Created by Anisha Ajani on 2/9/20.
//  Copyright © 2020 Michael Brewington. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func SignOut(_ sender: UIButton) {
          try! Auth.auth().signOut()
          self.performSegue(withIdentifier: "SignOut", sender: self)
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
