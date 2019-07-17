//
//  ViewController.swift
//  BreweryFinder
//
//  Created by Thomas Prezioso on 7/6/19.
//  Copyright © 2019 Thomas Prezioso. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var detailBreweryArray = [String : Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTitle()
        print(detailBreweryArray)
    }

    func setTitle() {
        navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.title = detailBreweryArray["name"] as? String

    }

}

