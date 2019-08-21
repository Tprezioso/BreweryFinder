//
//  SearchViewController.swift
//  BreweryFinder
//
//  Created by Thomas Prezioso on 8/7/19.
//  Copyright © 2019 Thomas Prezioso. All rights reserved.
//

import UIKit


class SearchViewController: UIViewController {
    @IBOutlet weak var breweryNameTextfield: UITextField!
    @IBOutlet weak var breweryCityTextfield: UITextField!
    @IBOutlet weak var breweryStateTextfield: UITextField!
    
    var name = ""
    var city = ""
    var state = ""

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        breweryNameTextfield.delegate = self
        breweryCityTextfield.delegate = self
        breweryStateTextfield.delegate = self
        
    }
    
    func convertForSearch() {
        self.name = breweryNameTextfield.text!.lowercased()
        self.city = breweryCityTextfield.text!.lowercased()
        self.state = breweryStateTextfield.text!.lowercased()
        
        self.name = name.replacingOccurrences(of: " ", with: "_")
        self.city = city.replacingOccurrences(of: " ", with: "_")
        self.state = state.replacingOccurrences(of: " ", with: "_")
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        convertForSearch()
        let destVC = segue.destination as! BreweryListTableViewController
        destVC.searchBreweryName = self.name
        destVC.searchBreweryCity = self.city
        destVC.searchBreweryState = self.state
    }

    // MARK: - Actions

    // MARK: - Touch Method for Keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        breweryNameTextfield.resignFirstResponder()
        breweryCityTextfield.resignFirstResponder()
        breweryStateTextfield.resignFirstResponder()
    }
}

    // MARK: - UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
