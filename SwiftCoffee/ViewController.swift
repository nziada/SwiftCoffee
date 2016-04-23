    //
//  ViewController.swift
//  explore-swift
//
//  Created by Nader Ziada on 2016-04-12.
//  Copyright © 2016 NZ. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{

    @IBOutlet weak var map: MKMapView!
    let locationManager = CLLocationManager()
    var lastLocation: CLLocation!
    var venus = [Venue]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        self.map.showsUserLocation = true
        
        if let loc = locationManager.location {
            print("1. present location : \(loc.coordinate.latitude), \(loc.coordinate.longitude)")
            self.lastLocation = loc
            getPlacesFromFoursquare(loc)
        }
    }
    
    func getPlacesFromFoursquare(location: CLLocation){
        print("about to call foursquare explore endpoint")
        
        let ll = "\(location.coordinate.latitude),\(location.coordinate.longitude)"

        let url = "https://api.foursquare.com/v2/venues/explore"
        let parameters = [
            "client_id": "F0JVULOGYRTCTCSVJOSIBU5JTIIWP3M3TIJ0TURSVCEWA0AB",
            "client_secret": "YHUTRJFBEXVFQMHHY0LUD21QPLMMXCHQ1RXQLD00JR0JNGKD",
            "ll": "\(ll)",
            "v": "20160416",
            "section": "coffee",
            "radius": "2000"
        ]
        
        Alamofire.request(.GET, url, parameters: parameters).responseJSON { response in
                
            guard response.result.error == nil else {
                // got an error in getting the data, need to handle it
                print("error calling GET on \(url)")
                print(response.result.error!)
                return
            }
            
            if let value = response.result.value {
                // handle the results as JSON, without a bunch of nested if loops
                let json = JSON(value)
                
                if let responseData = json["response"]["groups"][0]["items"].arrayObject {
                    let items = responseData as! [[String:AnyObject]]
                    var index = 0
                    for _ in items {
                        let id = json["response"]["groups"][0]["items"][index]["venue"]["id"].stringValue
                        let name = json["response"]["groups"][0]["items"][index]["venue"]["name"].stringValue
                        var address = "n/a"
                        if json["response"]["groups"][0]["items"][index]["venue"]["location"]["address"].exists(){
                            address = json["response"]["groups"][0]["items"][index]["venue"]["location"]["address"].stringValue
                        }
                        var city = "n/a"
                        if json["response"]["groups"][0]["items"][index]["venue"]["location"]["city"].exists(){
                            city = json["response"]["groups"][0]["items"][index]["venue"]["location"]["city"].stringValue
                        }
                        let distance = json["response"]["groups"][0]["items"][index]["venue"]["location"]["distance"].intValue
                        let lat = json["response"]["groups"][0]["items"][index]["venue"]["location"]["lat"].doubleValue
                        let lng = json["response"]["groups"][0]["items"][index]["venue"]["location"]["lng"].doubleValue
                        let venue = Venue(id: id, name: name, address: address, city: city, distance: distance, lat: lat, lng: lng)
                        self.venus.append(venue!)
                        index += 1
                    }
                }
            }
            
            FoursquarePlaces.updatePlaces(self.venus)
            
            for v in FoursquarePlaces.getPlaces() {
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocation(latitude: v.lat, longitude: v.lng).coordinate
                annotation.title = v.name
                annotation.subtitle = v.address
                
                self.map.addAnnotation(annotation)
            }

        }
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let location = locations.last
        
        if let loc = locations.last {
            print("2. present location : \(loc.coordinate.latitude), \(loc.coordinate.longitude)")
            if loc.distanceFromLocation(lastLocation) > 1000 {
                getPlacesFromFoursquare(loc)
            }
            self.lastLocation = loc
        }
        
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
        
        self.map.setRegion(region, animated: true)
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError){
        print("Error: " + error.localizedDescription)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

