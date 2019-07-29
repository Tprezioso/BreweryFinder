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
    
    var locationLat = 0.0
    var locationLong = 0.0
    
    var userLat = 0.0
    var userLong = 0.0
    
   
    // Mark: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationAuthorization()
       

//        getData()

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
            // Apple Inc.,
            // 1 Infinite Loop,
            // Cupertino, CA 95014
            // United States reversedGeoLocation.city reversedGeoLocation.state

            self.clientCall.searchBreweryByCity(city: "astoria", state:"new_york" , completion: { (json) in
                self.searchData = json!
                self.tableView.reloadData()
            })
        }

        struct ReversedGeoLocation {
            let name: String            // eg. Apple Inc.
            let streetName: String      // eg. Infinite Loop
            let streetNumber: String    // eg. 1
            let city: String            // eg. Cupertino
            let state: String           // eg. CA
            let zipCode: String         // eg. 95014
            let country: String         // eg. United States
            let isoCountryCode: String  // eg. US
            
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
    
    func getData() {
        DispatchQueue.main.async {
            self.clientCall.searchBreweryByName(completion: { (json) in
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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        self.arr  = arr.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        print("working")
        tableView.reloadData()
//

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            print("working")
//            getData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
                self.tableView.reloadData()
            }
        }
    }

}

extension BreweryListTableViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        userLat = locValue.latitude
        userLong = locValue.longitude
         self.getUserCity(latitude: userLat, longitude: userLong)
        //        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    

}
