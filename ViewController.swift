//
//  ViewController.swift
//  fastis
//
//  Created by Michael Brewington on 2/4/20.
//  Copyright © 2020 Michael Brewington. All rights reserved.
//The order still needs work.  I'd like to be able to save page location when user backpages.  

import UIKit
import Foundation
import Firebase
import SDWebImage

class NoteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var CellImage: UIImageView!
    
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var CreateFolderButton: UIButton!
    
    @IBOutlet weak var GreetingLabel: UILabel!
    
    var folderList = [Folders]()
    
    var ref: DatabaseReference!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        getUserData()
        tableView.delegate = self
        tableView.dataSource = self
        CreateFolderButton.layer.cornerRadius = 20
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
     }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.folderList.count
    }
    
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          self.performSegue(withIdentifier: "HomeToFolder", sender: self)
        
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            guard let destinationVC = segue.destination as? FolderViewController else {return}
            let selectedRow = indexPath.row
            destinationVC.uploadTitle = "\(folderList[selectedRow].title )"
            let folder = Folders(titleText: folderList[selectedRow].title, photoURL: folderList[selectedRow].photoUrl, DocumentID: folderList[selectedRow].documentID)
            destinationVC.folderList.append(folder)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "Note", for: indexPath) as! NoteTableViewCell
        cell.Label.text = folderList[indexPath.row].title
        cell.CellImage.layer.cornerRadius = 20
        let placeholderImage = UIImage(named: "placeholder.jpg")
        cell.CellImage.sd_setImage(with: URL(string: folderList[indexPath.row].photoUrl), placeholderImage: placeholderImage)
        return cell
    }
    
    func getData()
    {
        let userId = Auth.auth().currentUser?.uid
        let citiesRef = db.collection("users").document("\(userId!)").collection("posts")
        
        citiesRef.addSnapshotListener { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.folderList = []
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let name = document.data()["caption"] as! String
                    let photoUrl = document.data()["photoUrl"] as! String
                    let folder = Folders(titleText: name, photoURL: photoUrl, DocumentID: document.documentID)
                    self.folderList.append(folder)
                    print(self.folderList)
                    self.tableView.reloadData()
                }
            }
        }

    }
    
    var userList = [User]()
    
    func getUserData()
     {
         let userId = Auth.auth().currentUser?.uid
         let userEmail = Auth.auth().currentUser?.email
         
         db.collection("users").document("\(userId!)")
             .addSnapshotListener { documentSnapshot, error in
               guard let document = documentSnapshot else {
                 print("Error fetching document: \(error!)")
                 return
               }
               guard let data = document.data() else {
                 print("Document data was empty.")
                 return
               }
                self.userList = []
               print("Current data: \(data)")
                let name = data["Name"] as! String
                let user = User(uid: userId!, username: userEmail!, name: name)
                self.userList.append(user)
                print(self.userList)
                if(self.userList.count>0)
                      {
                        self.GreetingLabel.text = "Hello \(self.userList[0].name)!"
                      }
             }
     }

}
