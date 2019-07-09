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
    
    var breweryByNameURL = "https://api.openbrewerydb.org/breweries?by_name=cooper"
    typealias WebServiceResponse = ([[String: Any]]?) -> Void
    
    func searchBreweryByName(completion: @escaping WebServiceResponse) {
       
        Alamofire.request(breweryByNameURL, method: .get).responseJSON { (response) in
            if response.result.isSuccess {
                let data = response.result.value! as! [[String: AnyObject]]
                print(data)
                
                
            }
        }
    
    }
}
