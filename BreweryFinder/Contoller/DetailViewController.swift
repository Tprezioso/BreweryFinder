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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var webSiteLabel: UILabel!
    
    let locationManager = CLLocationManager()

    var detailBreweryArray = [String : Any]()
    var latitude = ""
    var longitude = ""
    let annotation = MKPointAnnotation()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitleForNavBar()
        print(detailBreweryArray)
        self.nameLabel.text = "\(String(describing: detailBreweryArray["name"]!))"
        self.detailLabel.text = "\(detailBreweryArray["street"]!)\n\(detailBreweryArray["city"]!),\(detailBreweryArray["state"]!) \n \(detailBreweryArray["postal_code"]!)  \(detailBreweryArray["country"]!)"
        
        self.phoneNumber.text = detailBreweryArray["phone"]! as? String
        
        self.webSiteLabel.text = detailBreweryArray["website_url"]! as? String
        
        
        latitude = (detailBreweryArray["latitude"] as! String)
        longitude = (detailBreweryArray["longitude"] as! String)
        
        let initialLocation = CLLocation(latitude: Double(latitude)! , longitude: Double(longitude)!)

        annotation.coordinate = CLLocationCoordinate2D(latitude: Double(latitude)!, longitude: Double(longitude)!)
        
        mapView.addAnnotation(annotation)
        centerMapOnLocation(location: initialLocation)
    }
    
    let regionRadius: CLLocationDistance = 100
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func setTitleForNavBar() {
        navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.title = detailBreweryArray["name"] as? String

    }
    @IBAction func callBrewery(_ sender: Any) {
        guard let number = URL(string: "tel://" + "3472183350") else { return }
        UIApplication.shared.open(number)
    }
    
}

