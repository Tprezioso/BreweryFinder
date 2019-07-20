//
//  ViewController.swift
//  BreweryFinder
//
//  Created by Thomas Prezioso on 7/6/19.
//  Copyright © 2019 Thomas Prezioso. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()

    var detailBreweryArray = [String : Any]()
    var latitude = ""
    var longitude = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitleForNavBar()
        print(detailBreweryArray)
        
        latitude = (detailBreweryArray["latitude"] as! String)
        longitude = (detailBreweryArray["longitude"] as! String)
        
        let initialLocation = CLLocation(latitude: Double(latitude)! , longitude: Double(longitude)!)

        centerMapOnLocation(location: initialLocation)
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }


    
    func setTitleForNavBar() {
        navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.title = detailBreweryArray["name"] as? String

    }

}

