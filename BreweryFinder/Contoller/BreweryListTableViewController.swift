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

    @IBOutlet weak var searchBar: UISearchBar!
    
    var clientCall = ClientCall()
    var searchData = [[String : Any]]()
    
    var userLat = 0.0
    var userLong = 0.0
   
    // Mark: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        locationAuthorization()
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
            
            // Code below removed for testing!
            // reversedGeoLocation.city reversedGeoLocation.state
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

//            self.clientCall.searchBreweryByName(completion: { (json) in
//                self.searchData = json!
//                self.tableView.reloadData()
//            })
            
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let  destinationVC = segue.destination as! DetailViewController

        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.detailBreweryArray = searchData[indexPath.row] 
        }
    }

}

// MARK: - Search Bar Methods

extension BreweryListTableViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchBar.text?.count == 0 {
            print("searchText \(searchText)")
//            getData()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //        self.searchData["name"] = searchData.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        print("searchText \(String(describing: searchBar.text))")
        //        tableView.reloadData()
        //        searchBar.resignFirstResponder()
        
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
