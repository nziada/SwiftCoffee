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
    var fs: FoursquareApi
    
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var CurrentLocationButton: UIButton!
    
    
    init(foursquareApi: FoursquareApi!) {
        if let f = foursquareApi {
            self.fs = f
        } else {
            self.fs = FoursquareApi()
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    init(){
        self.fs = FoursquareApi()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder aDecoder: (NSCoder!)) {
        self.fs = FoursquareApi()
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        self.map.showsUserLocation = true
        self.map.setUserTrackingMode(MKUserTrackingMode.Follow, animated: true)
        
        if let loc = locationManager.location {
            callFoursquare(loc)
        }
    }
    
    func callFoursquare(loc: CLLocation){
        
        print("1. present location : \(loc.coordinate.latitude), \(loc.coordinate.longitude)")
        self.lastLocation = loc
        //getPlacesFromFoursquare(loc)
        fs.getPlacesFromFoursquare(loc){ responseObject, error in
            
            guard error == nil else{
                print("error calling GET on Foursquare Explore")
                print(error!)
                return
            }
            
            if let value = responseObject {
                self.parseFoursquareResponse(value)
            }
            
            for v in FoursquarePlaces.getPlaces() {
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocation(latitude: v.lat, longitude: v.lng).coordinate
                annotation.title = v.name
                annotation.subtitle = v.address
                
                self.map.addAnnotation(annotation)
            }
            
            return
        }
    }
    
    func parseFoursquareResponse(responseObject: NSDictionary){
        // handle the results as JSON, without a bunch of nested if loops
        let json = JSON(responseObject)
        
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

        FoursquarePlaces.updatePlaces(self.venus)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let location = locations.last
        
        if let loc = locations.last {
            print("2. present location : \(loc.coordinate.latitude), \(loc.coordinate.longitude)")
            if let last = lastLocation {
                if loc.distanceFromLocation(last) > 1000 {
                    callFoursquare(loc)
                }
            } else {
                callFoursquare(loc)
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
    
    @IBAction func showCurrentPosition(sender: AnyObject) {
        if let location = locationManager.location {
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
            
            self.map.setRegion(region, animated: true)
        }
    }
    
    @IBAction func refreshAction(sender: AnyObject) {
        if let location = locationManager.location {
            callFoursquare(location)
        }
    }

}

