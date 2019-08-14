//
//  ClientCall.swift
//  BreweryFinder
//
//  Created by Thomas Prezioso on 7/9/19.
//  Copyright © 2019 Thomas Prezioso. All rights reserved.
//

import Foundation
import Alamofire

class ClientCall {

    var breweryByNameURL = "https://api.openbrewerydb.org/breweries?by_name=a"
    
    typealias WebServiceResponse = ([[String: Any]]?) -> Void
    
    // MARK: - Search by Brewery Name
    func searchBreweryByName(completion: @escaping WebServiceResponse) {
       
        Alamofire.request(breweryByNameURL, method: .get).responseJSON { (response) in
            if response.result.isSuccess {
                
                let data = response.result.value! as! [[String: AnyObject]]
//                print(data[0]["name"])
                completion(data)
            }
        }
    
    }
    
    // MARK: - Search by City and State
    #warning("This need to be fixed to get a list of breweries for user on load")
    
    func searchBreweryByCity(city: String, state: String, completion: @escaping WebServiceResponse) {
        let breweryByCityURL = "https://api.openbrewerydb.org/breweries?by_city=\(city)&by_state=\(state)"

        Alamofire.request(breweryByCityURL, method: .get).responseJSON { (response) in
            if response.result.isSuccess {
                let data = response.result.value! as! [[String: AnyObject]]
                //                print(data[0]["name"])
                completion(data)
            }
        }
    }
    
}
