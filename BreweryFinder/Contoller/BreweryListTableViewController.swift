//
//  BreweryListTableViewController.swift
//  BreweryFinder
//
//  Created by Thomas Prezioso on 7/6/19.
//  Copyright © 2019 Thomas Prezioso. All rights reserved.
//

import UIKit
import CoreLocation

class BreweryListTableViewController: UITableViewController {

    let locationManager = CLLocationManager()
    var userLat = 0.0
    var userLong = 0.0

    var clientCall = ClientCall()
    var searchData = [[String : Any]]()
    
    var searchBreweryName = ""
    var searchBreweryState = ""
    var searchBreweryCity = ""
    
    // Mark: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationAuthorization()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // This is where you need to add the call to search api and reload tableview
        print(searchBreweryName)
    }
    
    // Mark: - Map Stuff
    func locationAuthorization() {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self as CLLocationManagerDelegate
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }

    }
    
    func getUserCity(latitude: Double, longitude: Double) {
        let location = CLLocation(latitude: userLat, longitude: userLong)
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            
            guard let placemark = placemarks?.first else {
                let errorString = error?.localizedDescription ?? "Unexpected Error"
                print("Unable to reverse geocode the given location. Error: \(errorString)")
                return
            }
            
            let reversedGeoLocation = ReversedGeoLocation(with: placemark)
            print(reversedGeoLocation.city)
            
            // Code below replace params when done testing!
            // reversedGeoLocation.city reversedGeoLocation.state
            // Testing data in line below ...
            self.getUserLoacationData(city: "brooklyn", state: "new_york")
        }

        struct ReversedGeoLocation {
            let name: String
            let streetName: String
            let streetNumber: String
            let city: String
            let state: String
            let zipCode: String
            let country: String
            let isoCountryCode: String
            
            var formattedAddress: String {
                return """
                \(name),
                \(streetNumber) \(streetName),
                \(city), \(state) \(zipCode)
                \(country)
                """
        }
            
            // Handle optionals as needed
            init(with placemark: CLPlacemark) {
                self.name           = placemark.name ?? ""
                self.streetName     = placemark.thoroughfare ?? ""
                self.streetNumber   = placemark.subThoroughfare ?? ""
                self.city           = placemark.locality ?? ""
                self.state          = placemark.administrativeArea ?? ""
                self.zipCode        = placemark.postalCode ?? ""
                self.country        = placemark.country ?? ""
                self.isoCountryCode = placemark.isoCountryCode ?? ""
            }
        }

    }
    
    // MARK: - Retrive Data
    
    func getUserLoacationData(city: String, state: String) {
        DispatchQueue.main.async {
            self.clientCall.searchBreweryByCity(city: city, state: state , completion: { (json) in
                self.searchData = json!
                self.tableView.reloadData()
            })
        }
    
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BreweryCell", for: indexPath)
        cell.textLabel?.text = self.searchData[indexPath.row]["name"] as! String?

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegue(withIdentifier: "detailSegueIdentifier", sender: self)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "search" {
            let  destinationVC = segue.destination as! DetailViewController

            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.detailBreweryArray = searchData[indexPath.row]
            }
        }
        
    }
    
    @IBAction func unwindToBreweryList(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
        print()
    }
    
}

extension BreweryListTableViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        userLat = locValue.latitude
        userLong = locValue.longitude
         self.getUserCity(latitude: userLat, longitude: userLong)
    }

}
