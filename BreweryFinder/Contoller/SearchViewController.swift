//
//  SearchViewController.swift
//  BreweryFinder
//
//  Created by Thomas Prezioso on 8/7/19.
//  Copyright © 2019 Thomas Prezioso. All rights reserved.
//

import UIKit


class SearchViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return states.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return states[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        breweryStateTextfield.text = states[row]
    }
    
    @IBOutlet weak var breweryNameTextfield: UITextField!
    @IBOutlet weak var breweryCityTextfield: UITextField!
    @IBOutlet weak var breweryStateTextfield: UITextField!
    
    var name = ""
    var city = ""
    var state = ""
    
    let states = ["Alaska",
                  "Alabama",
                  "Arkansas",
                  "American Samoa",
                  "Arizona",
                  "California",
                  "Colorado",
                  "Connecticut",
                  "District of Columbia",
                  "Delaware",
                  "Florida",
                  "Georgia",
                  "Guam",
                  "Hawaii",
                  "Iowa",
                  "Idaho",
                  "Illinois",
                  "Indiana",
                  "Kansas",
                  "Kentucky",
                  "Louisiana",
                  "Massachusetts",
                  "Maryland",
                  "Maine",
                  "Michigan",
                  "Minnesota",
                  "Missouri",
                  "Mississippi",
                  "Montana",
                  "North Carolina",
                  " North Dakota",
                  "Nebraska",
                  "New Hampshire",
                  "New Jersey",
                  "New Mexico",
                  "Nevada",
                  "New York",
                  "Ohio",
                  "Oklahoma",
                  "Oregon",
                  "Pennsylvania",
                  "Puerto Rico",
                  "Rhode Island",
                  "South Carolina",
                  "South Dakota",
                  "Tennessee",
                  "Texas",
                  "Utah",
                  "Virginia",
                  "Virgin Islands",
                  "Vermont",
                  "Washington",
                  "Wisconsin",
                  "West Virginia",
                  "Wyoming"]

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        var pickerView = UIPickerView()
        pickerView.delegate = (self as! UIPickerViewDelegate)
        breweryStateTextfield.inputView = pickerView
        
        breweryNameTextfield.delegate = self
        breweryCityTextfield.delegate = self
        breweryStateTextfield.delegate = self
        
    }
    
    func convertForSearch() {
        self.name = breweryNameTextfield.text!.lowercased().trimmingTrailingSpaces()
        self.city = breweryCityTextfield.text!.lowercased().trimmingTrailingSpaces()
        self.state = breweryStateTextfield.text!.lowercased().trimmingTrailingSpaces()
        
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

extension String {
    
    func trimmingTrailingSpaces() -> String {
        var t = self
        while t.hasSuffix(" ") {
            t = "" + t.dropLast()
        }
        return t
    }
    
    mutating func trimmedTrailingSpaces() {
        self = self.trimmingTrailingSpaces()
    }
    
}

    // MARK: - UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
