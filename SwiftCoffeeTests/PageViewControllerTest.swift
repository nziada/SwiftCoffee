//
//  PageViewControllerTest.swift
//  SwiftCoffee
//
//  Created by Nader Ziada on 2016-04-24.
//  Copyright © 2016 NZ. All rights reserved.
//

import XCTest
@testable import SwiftCoffee

class PageViewControllerTest: XCTestCase {
    
    var vc : PageViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: NSBundle(forClass: self.dynamicType))
        vc = storyboard.instantiateViewControllerWithIdentifier("pagesController") as! PageViewController
        vc.loadView()
    }
    
    func testPagesAreLoaded(){
        XCTAssertEqual(vc.orderedViewControllers.count, 2)
    }
    
}
