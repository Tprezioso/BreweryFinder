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
        // Do any additional setup after loading the view.
        navigationItem.largeTitleDisplayMode = .never
        
        self.navigationItem.title = detailBreweryArray["name"] as? String
        print(detailBreweryArray)
    }


}

