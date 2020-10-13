//
//  FolderViewController.swift
//  fastis
//
//  Created by Anisha Ajani on 2/9/20.
//  Copyright © 2020 Michael Brewington. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import SDWebImage

class FolderViewController: UIViewController {
    
    var uploadTitle = ""
    var folderList = [Folders]()
    
    var ref: DatabaseReference!
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var FolderTitle: UILabel!
    @IBOutlet weak var FolderImage: UIImageView!
    @IBOutlet weak var ServiceBar: UIButton!
    @IBOutlet weak var TableView: UITableView!
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        ServiceBar.layer.cornerRadius = 20
        FolderTitle.text = uploadTitle
    }

    @IBAction func BackButton(_ sender: Any) {
        self.performSegue(withIdentifier: "FolderToHome", sender: self)
    }
    
    func getData()
    {
        if (folderList.count > 0)
        {
            print(folderList[0].documentID)
            FolderTitle.text = folderList[0].title
            let placeholderImage = UIImage(named: "placeholder.jpg")
            FolderImage.sd_setImage(with: URL(string: folderList[0].photoUrl), placeholderImage: placeholderImage)
        }
    }

}
