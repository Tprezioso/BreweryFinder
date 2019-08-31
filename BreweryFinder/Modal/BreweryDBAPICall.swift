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
    
    func getLoacalBrewey(lat: Double, lng: Double) {
        let requestURLLocalBreweries = "\(sandboxURL)/search/geo/point?lat=35.772096&lng=-78.638614\(sandboxKey)"

        Alamofire.request(requestURLLocalBreweries, method: .get).responseJSON { (response) in
            if response.result.isSuccess {
                print(response.result.value ?? "Nothing was found")
            }
        }

    }

}
