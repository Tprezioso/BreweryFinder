//
//  BreweryDBAPICall.swift
//  BreweryFinder
//
//  Created by Thomas Prezioso on 8/31/19.
//  Copyright © 2019 Thomas Prezioso. All rights reserved.
//

import Foundation
import Alamofire

class BreweryDBAPICall {

    var sandboxURL = "https://sandbox-api.brewerydb.com/v2/"
    var sandboxKey = "12c7fa76fb0323886d57b76a2d5d4bf4"
    
    //https://sandbox-api.brewerydb.com/v2/locations?key=12c7fa76fb0323886d57b76a2d5d4bf4&geo=1&lat=38.875532&lng=-77.007294&radius=30&units=m
    
    func getLoacalBrewey(lat: Double, lng: Double) {
        let requestURLLocalBreweries = "\(sandboxURL)locations?key=\(sandboxKey)&geo=1&lat=\(lat)&lng=\(lng)&radius=30&units=m"

        Alamofire.request(requestURLLocalBreweries, method: .get).responseJSON { (response) in
            if response.result.isSuccess {
                print(response.result.value ?? "Nothing was found")
            }
        }

    }

}
