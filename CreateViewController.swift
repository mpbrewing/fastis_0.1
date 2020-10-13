//
//  CreateViewController.swift
//  fastis
//
//  Created by Anisha Ajani on 2/9/20.
//  Copyright © 2020 Michael Brewington. All rights reserved.
//

import UIKit
import Foundation
import Firebase

struct defaultsCreate {
    static var count = 0
}

class CreateViewController: UIViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    var currentImageView: UIImageView?
    
    let db = Firestore.firestore()
    
    let imagePicker = UIImagePickerController()
    
  func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
    if let PickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.currentImageView?.image = PickedImage
            self.currentImageView?.clipsToBounds = true
        }
        dismiss(animated: true, completion: nil)
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        //PhotoButton.layer.opacity = 0.5
        PhotoButton.layer.cornerRadius = 20
        FolderPhoto.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
         imagePicker.delegate = self
        ContinueButton.layer.cornerRadius = 15
        TextField.attributedPlaceholder = NSAttributedString(string: "| type here...",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1)])
    }
    @IBOutlet weak var FolderPhoto: UIImageView!
    
    @IBOutlet weak var TextField: UITextField!
    @IBOutlet weak var ContinueButton: UIButton!
    @IBAction func ContinueAction(_ sender: Any) {

        createPosts(image: FolderPhoto.image)
        self.performSegue(withIdentifier: "CreateToHome", sender: self)
        self.reloadInputViews()
    }
    
    @IBOutlet weak var PhotoButton: UIButton!
    @IBAction func PhotoAction(_ sender: Any) {
        self.currentImageView = self.FolderPhoto
               imagePicker.allowsEditing = true
                   imagePicker.sourceType = .photoLibrary
               
               present(imagePicker, animated:true, completion: nil)
    }
    
    
    func createPosts(image: UIImage?)
    {
        if image != nil {
      var ref: DocumentReference? = nil
            
      let uuid = UUID().uuidString
        
      let userId = Auth.auth().currentUser?.uid
        
      let imageRef = Storage.storage().reference().child("gs:/profiles/\(userId!)_\(uuid).jpg")
          guard let imageData = image!.jpegData(compressionQuality: 0.1) else {
          return
      }
        
        imageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
                // 3
                if let error = error {
                    assertionFailure(error.localizedDescription)
                    return
                }
                // 4
                imageRef.downloadURL(completion: { (url, error) in
                    if let error = error {
                        assertionFailure(error.localizedDescription)
                        return
                    }
                    let someValue: String? = "\(url!)"
                    
                    ref = self.db.collection("users").document("\(userId!)").collection("posts").addDocument(data: [
                        "caption": "\(self.TextField.text!)",
                        "photoUrl": someValue!
                    ]) { err in
                        if let err = err {
                            print("Error adding document: \(err)")
                        } else {
                            print("Document added with ID: \(ref!.documentID)")
                        }
                    }
                })
            })
        }
    }
}
