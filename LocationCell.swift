//
//  LocationCell.swift
//  fastis
//
//  Created by Michael Brewington on 3/20/20.
//  Copyright © 2020 Michael Brewington. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class LocationCell: UIViewController, UISearchBarDelegate {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func awakeFromNib() {
    super.awakeFromNib()
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        //textView.resignFirstResponder()
        searchController.searchBar.searchTextField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        self.tableView.backgroundColor = UIColor.white
        
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Top Modern as created using Fon", size: 24), NSAttributedString.Key.foregroundColor: UIColor.black]
        let attributes2 = [NSAttributedString.Key.font: UIFont(name: "Top Modern as created using Fon", size: 20), NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = attributes as [NSAttributedString.Key : Any]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes2 as [NSAttributedString.Key : Any], for: .normal)
        
        searchController.searchBar.searchTextField.backgroundColor = UIColor.white
        //searchController.searchBar.barTintColor = UIColor.white
        searchController.searchBar.placeholder = "Add location"
        searchController.searchBar.setMagnifyingGlassColorTo(color: UIColor.darkGray)
        //navigationItem.searchController = searchController
        searchController.searchBar.sizeToFit()
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.titleView = searchController.searchBar
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "LocationCellView", bundle: nil), forCellReuseIdentifier: "locationXib")
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
         //change searchCompleter depends on searchBar's text
               if !searchText.isEmpty {
                   searchCompleter.queryFragment = searchText
               } else {
                searchResults.removeAll()
                searchSource?.removeAll()
                tableView.reloadData()
        }
    }
    
    /*
    func passData()
    {
        let string = "\(one) \(text) before"
        let myDict = ["notif": string] as [String : Any]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notif"), object: myDict)
    }
    */
    
    var locations = [LocationClass]()
    var searchResults = [MKLocalSearchCompletion]()
     //create a completer
       lazy var searchCompleter: MKLocalSearchCompleter = {
           let sC = MKLocalSearchCompleter()
        sC.delegate = (self as MKLocalSearchCompleterDelegate)
           return sC
       }()

       var searchSource: [String]?
    
}

extension LocationCell: UITableViewDataSource, UITableViewDelegate, UITextViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return searchSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationXib", for: indexPath) as! LocationViewCellClass
       // let location = locations[indexPath.row]
       // cell.configureLocationCell(locationName: location.locationName, location: location.location)
        let searchResult = searchResults[indexPath.row]
        cell.Name.text = self.searchSource?[indexPath.row]
        cell.location.text = searchResult.subtitle
        //            + " " + searchResult.subtitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let searchResult = searchResults[indexPath.row]
        //searchResult.title
        //Pass data
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            self.tableView.reloadData()
            //Segue and Pass Location Text Input
        }
        return true
    }
    
    
    
}

extension LocationCell: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        //get result, transform it to our needs and fill our dataSource
        searchResults = completer.results
        self.searchSource = completer.results.map { $0.title }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        //handle the error
        print(error.localizedDescription)
    }
}

extension UISearchBar
{
    func setPlaceholderTextColorTo(color: UIColor)
    {
        let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = color
        let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideSearchBarLabel?.textColor = color
        
        //UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.white
        //UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).layer.cornerRadius = 10
       // UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).clipsToBounds = true
    }

    func setMagnifyingGlassColorTo(color: UIColor)
    {
        let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField
        let glassIconView = textFieldInsideSearchBar?.leftView as? UIImageView
        glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
        glassIconView?.tintColor = color
    }
    
}

extension UINavigationBar {
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 60)
    }
}

class LocationViewCellClass: UITableViewCell{
    
    override func awakeFromNib() {
    super.awakeFromNib()
    }
    
    
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var location: UILabel!
    
    func configureLocationCell(locationName: String, location: String) {
         self.Name.text = locationName
         self.location.text = location
    }
    
}
