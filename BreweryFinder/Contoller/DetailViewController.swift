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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        setTitleForNavBar()
        print(detailBreweryArray)
        
        var lat = ""
        var longg = ""
        
        lat = (detailBreweryArray["latitude"] as! String)
        longg = (detailBreweryArray["longitude"] as! String)
        
        print(lat)
        
        let initialLocation = CLLocation(latitude: Double(lat) as! CLLocationDegrees, longitude: Double(longg) as! CLLocationDegrees)

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

