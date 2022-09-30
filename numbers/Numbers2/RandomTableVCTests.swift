//
//  Numbers2Tests.swift
//  Numbers2Tests
//
//  Created by Ramar Parham on 12/10/19.
//
//

import XCTest
@testable import Numbers2

class RandomTableVCTests: XCTestCase {
    
    var randomTableVC: RandomTableVC?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // Were going to make a new storyboard object, and then access the view controller we have.
        // method instantiateViewController returns back a UIViewController, but we are casting the return object to the class we made since that is what we're accessing.
        if let vc = UIStoryboard(name: StoryboardId.main.id, bundle: nil).instantiateViewController(identifier: ViewControllerId.randomTableVC.id) as? RandomTableVC {
            // Assinging local variable to the reference created from the above method.
            randomTableVC = vc
            randomTableVC?.loadView()
        } else {
            XCTFail()
        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        randomTableVC = nil
    }
    
    func testOutlets() {
        XCTAssertNotNil(randomTableVC?.buttonTextFieldStackView)
        XCTAssertNotNil(randomTableVC?.categoryButton)
        XCTAssertNotNil(randomTableVC?.numberTextField)
        XCTAssertNotNil(randomTableVC?.factsTableView)
        XCTAssertNotNil(randomTableVC?.goButton)
        XCTAssertNotNil(randomTableVC?.textFieldButtonStackView)
    }
}
