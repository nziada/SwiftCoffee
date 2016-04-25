//
//  FoursquareApi.swift
//  SwiftCoffee
//
//  Created by Nader Ziada on 2016-04-24.
//  Copyright © 2016 NZ. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON

protocol FoursquareProtocol {
    func getPlacesFromFoursquare(location: CLLocation, completionHandler: (NSDictionary?, NSError?) -> ())
}

class FoursquareApi: FoursquareProtocol{

    func getPlacesFromFoursquare(location: CLLocation, completionHandler: (NSDictionary?, NSError?) -> ()) {
        makeCall(location, completionHandler: completionHandler)
    }

    func makeCall(location: CLLocation, completionHandler: (NSDictionary?, NSError?) -> ()) {
    
        print("about to call foursquare explore endpoint")
        
        let ll = "\(location.coordinate.latitude),\(location.coordinate.longitude)"
        
        let url = "https://api.foursquare.com/v2/venues/explore"
        let parameters = [
            "client_id": "F0JVULOGYRTCTCSVJOSIBU5JTIIWP3M3TIJ0TURSVCEWA0AB",
            "client_secret": "YHUTRJFBEXVFQMHHY0LUD21QPLMMXCHQ1RXQLD00JR0JNGKD",
            "ll": "\(ll)",
            "v": "20160416",
            "section": "coffee",
            "radius": "5000"
        ]
        
        Alamofire.request(.GET, url, parameters: parameters).responseJSON { response in
            
            switch response.result {
            case .Success(let value):
                print("====")
                print(value)
                print("====")
                
                completionHandler(value as? NSDictionary, nil)
            case .Failure(let error):
                completionHandler(nil, error)
            }
        }
    }

}
