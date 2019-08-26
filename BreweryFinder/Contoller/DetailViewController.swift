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
    @IBOutlet weak var webSiteLabel: UILabel!
    @IBOutlet weak var phoneLabel: UIButton!
    
    let locationManager = CLLocationManager()

    var detailBreweryArray = [String : Any]()
    var latitude = ""
    var longitude = ""
    let annotation = MKPointAnnotation()

    // MARK: - Life Cycle
   
    override func viewDidLoad() {
        super.viewDidLoad()

        setTitleForNavBar()
        print(detailBreweryArray)
        self.nameLabel.text = "\(String(describing: detailBreweryArray["name"]!))"

//        return """
//        \(name),
//        \(streetNumber) \(streetName),
//        \(city), \(state) \(zipCode)
//        \(country)
//        """

        self.detailLabel.text = "\(detailBreweryArray["street"]!)\n\(detailBreweryArray["city"]!),\(detailBreweryArray["state"]!) \n \(detailBreweryArray["postal_code"]!)  \(detailBreweryArray["country"]!)"
        
        self.phoneLabel.setTitle(detailBreweryArray["phone"] as? String, for: .normal)

        self.webSiteLabel.text = detailBreweryArray["website_url"]! as? String
        
        setMapLocationPin()
    }
    
    // MARK: - Map Setup
    
    func setMapLocationPin() {
        let location = "\(detailBreweryArray["street"]!), \(detailBreweryArray["state"]!), \(detailBreweryArray["postal_code"]!)"
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location) { [weak self] placemarks, error in
            if let placemark = placemarks?.first, let location = placemark.location {
                let mark = MKPlacemark(placemark: placemark)
                
                self!.annotation.coordinate = mark.coordinate
                self!.annotation.title = "\(self!.detailBreweryArray["name"]!)"
                
                if var region = self?.mapView.region {
                    region.center = location.coordinate
                    region.span.longitudeDelta = 0.001
                    region.span.latitudeDelta = 0.001

                    self?.mapView.setRegion(region, animated: true)
                    self?.mapView.addAnnotation(self!.annotation)
                }
            }
        }
        

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
   
    // MARK: - Phone call
    
    @IBAction func callBrewery(_ sender: Any) {
        guard let number = URL(string: "tel://" + "3472183350") else { return }
        UIApplication.shared.open(number)
    }
    
}


