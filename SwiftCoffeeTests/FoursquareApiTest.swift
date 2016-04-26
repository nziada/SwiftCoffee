//
//  FoursquareApiTest.swift
//  SwiftCoffee
//
//  Created by Nader Ziada on 4/25/16.
//  Copyright © 2016 NZ. All rights reserved.
//

import XCTest
import Nimble
@testable import SwiftCoffee

class FoursquareApiTest: XCTestCase {
    
    var vc : ViewController!

    override func setUp() {
        super.setUp()
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: NSBundle(forClass: self.dynamicType))
        vc = storyboard.instantiateViewControllerWithIdentifier("mapView") as! ViewController
        let fake = FakeFoursquareApi()
        vc.setFoursquareApi(fake)
        vc.loadView()
    }
    
    func testFoursquareIsCalledOnLoad(){
        expect(self.vc.venus).toNot(beNil())
        expect(self.vc.venus).toNot(beEmpty())
        expect(self.vc.venus[0].name).to(equal("Starbucks"))
        expect(self.vc.venus[0].address).to(equal("1 Toronto St"))
        expect(self.vc.venus[0].city).to(equal("Toronto"))
        expect(self.vc.venus[0].distance).to(equal(400))
        expect(self.vc.venus[0].lat).to(equal(34.34))
        expect(self.vc.venus[0].lng).to(equal(-122.20))
    }

}
