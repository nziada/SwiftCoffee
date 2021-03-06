//
//  UIElementsTests.swift
//  SwiftCoffee
//
//  Created by Nader Ziada on 2016-04-26.
//  Copyright © 2016 NZ. All rights reserved.
//

import XCTest
import Nimble

class UIElementsTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    func testUiElements() {

        XCUIApplication().childrenMatchingType(.Window).elementBoundByIndex(0).childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).elementBoundByIndex(1).childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.tap()
        let app = XCUIApplication()
        app.childrenMatchingType(.Window).elementBoundByIndex(0).childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).elementBoundByIndex(1).childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.tap()
        
        expect(XCUIApplication().buttons.count).to(equal(2))
        expect(app.buttons["Near Me Filled"].exists).to(equal(true))
        expect(app.buttons["Restart Filled"].exists).to(equal(true))
        
        

    }
    
}
