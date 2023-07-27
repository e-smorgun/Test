//
//  TestTests.swift
//  TestTests
//
//  Created by Evgeny on 27.07.23.
//

import XCTest
@testable import Test

class DataServiceTests: XCTestCase {
    
    var sut: DataService!
    
    override func setUp() {
        super.setUp()
        sut = DataService()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testGetFlight() {
        // Given
        let expectation = self.expectation(description: "Get flight completion")
        
        // When
        sut.getFlight { result in
            // Then
            switch result {
            case .success(let flightResult):
                XCTAssertNotNil(flightResult)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Failed to get flight with error: \(error.localizedDescription)")
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
