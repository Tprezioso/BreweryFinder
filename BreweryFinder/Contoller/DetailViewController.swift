//
//  ViewController.swift
//  BreweryFinder
//
//  Created by Thomas Prezioso on 7/6/19.
//  Copyright © 2019 Thomas Prezioso. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

    var detailBreweryArray = [String : Any]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setTitleForNavBar()
        print(detailBreweryArray)
    }

    func setTitleForNavBar() {
        navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.title = detailBreweryArray["name"] as? String

    }

}

