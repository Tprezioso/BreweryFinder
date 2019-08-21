//
//  SearchViewController.swift
//  BreweryFinder
//
//  Created by Thomas Prezioso on 8/7/19.
//  Copyright © 2019 Thomas Prezioso. All rights reserved.
//

import UIKit

protocol SearchViewControllerDelegate: AnyObject {
    func update(_ name: String)
}

class SearchViewController: UIViewController {
    @IBOutlet weak var breweryNameTextfield: UITextField!
    @IBOutlet weak var breweryCityTextfield: UITextField!
    @IBOutlet weak var breweryStateTextfield: UITextField!
    
    weak var delegate: SearchViewControllerDelegate!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        breweryNameTextfield.delegate = self
        breweryCityTextfield.delegate = self
        breweryStateTextfield.delegate = self
        
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! BreweryListTableViewController
        destVC.searchBreweryName = breweryNameTextfield.text!
    
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
