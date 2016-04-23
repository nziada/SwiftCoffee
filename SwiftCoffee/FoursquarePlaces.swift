//
//  FoursquarePlaces.swift
//  SwiftCoffee
//
//  Created by Nader Ziada on 2016-04-22.
//  Copyright © 2016 NZ. All rights reserved.
//

import Foundation

class FoursquarePlaces {
    
    static let sharedInstance = FoursquarePlaces()
    
    static var places = [Venue]()
    
    private init() {} //This prevents others from using the default '()' initializer for this class.
    
    class func getPlaces() -> Array<Venue> {
        return self.places;
    }
    
    class func updatePlaces(inputArray:Array<Venue>) {
        self.places = inputArray
    }
}