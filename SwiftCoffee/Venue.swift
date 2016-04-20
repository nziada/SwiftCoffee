//
//  Venue.swift
//  SwiftCoffee
//
//  Created by Nader Ziada on 2016-04-19.
//  Copyright © 2016 NZ. All rights reserved.
//

import Foundation

class Venue {
    
    var name: String
    var address: String
    var city: String
    var distance: Double
    var lat: Double
    var lng: Double
    
    // MARK: Initialization
    
    init?(name: String, address: String, city: String, distance: Double, lat: Double, lng: Double) {
        
        // Initialize stored properties.
        self.name = name
        self.address = address
        self.city = city
        
        self.distance = distance
        self.lat = lat
        self.lng = lng
        
        if name.isEmpty {
            return nil
        }
        
    }
}
