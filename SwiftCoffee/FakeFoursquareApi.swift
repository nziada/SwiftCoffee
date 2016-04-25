//
//  FakeFoursquareApi.swift
//  SwiftCoffee
//
//  Created by Nader Ziada on 2016-04-24.
//  Copyright © 2016 NZ. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON

class FakeFoursquareApi: FoursquareProtocol {
    
    func getPlacesFromFoursquare(location: CLLocation, completionHandler: (NSDictionary?, NSError?) -> ()) {
        makeCall(location, completionHandler: completionHandler)
    }
    
    func makeCall(location: CLLocation, completionHandler: (NSDictionary?, NSError?) -> ()) {
        
        print("about to call fake foursquare explore endpoint")
        
        let value: NSDictionary = [
            "meta" : ["code" : "200"]
        ]

        completionHandler(value as NSDictionary, nil)
        return

    }

}
