//
//  NetworkManagerTests.swift
//  Numbers2Tests
//
//  
//
//

import XCTest
@testable import Numbers2

class NetworkManagerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAPICall() {
        // Testing APIs (network calls that can take time).
        let expectation = XCTestExpectation()
        
        let manager = NetworkManager()
        manager.call(using: 1729) { (data) in
            // To use on Decodable, you have to use JSONDecoder().decode method.
            if let numberFact: NumberFactModel = try? JSONDecoder().decode(NumberFactModel.self, from: data) {
                XCTAssertEqual(numberFact.number, 1729)
                XCTAssertFalse(numberFact.description.isEmpty)
                XCTAssertFalse(numberFact.type.isEmpty)
            // Recommend adding an else case for `if let` if they fail.
            } else {
                XCTFail("Could not create a new NumberFactModel from the data.")
            }
            // This fullfillment is only triggered after the completionHandler of call method is called.
            // This tells line 35 when the unit test is waiting to finish waiting and succeed.
            expectation.fulfill()
        }
        
        // If the network calls takes more than 10 seconds, the test will fail because it never eached
        // line 28, where it is fulfilled.
        wait(for: [expectation], timeout: 10)
    }
}
