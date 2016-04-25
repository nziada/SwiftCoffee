//
//  MapViewControllerTest.swift
//  SwiftCoffee
//
//  Created by Nader Ziada on 2016-04-24.
//  Copyright © 2016 NZ. All rights reserved.
//

import XCTest
import Nimble
@testable import SwiftCoffee

class MapViewControllerTest: XCTestCase {
    
    var vc : ViewController!

    override func setUp() {
        super.setUp()
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: NSBundle(forClass: self.dynamicType))
        vc = storyboard.instantiateViewControllerWithIdentifier("mapView") as! ViewController
        vc.loadView()    }
    
    func testFoursquareIsCalledOnLoad(){
        expect(self.vc.venus).toNot(beNil())
        expect(self.vc.venus).toNot(beEmpty())
    }
    
}
