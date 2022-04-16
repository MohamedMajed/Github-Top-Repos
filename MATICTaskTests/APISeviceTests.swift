//
//  APISeviceTests.swift
//  MATICTaskTests
//
//  Created by Mohamed Maged on 15/04/2022.
//

import XCTest

@testable import MATICTask

class APISeviceTests: XCTestCase {
    
    var sut: APIService!

    override func setUp() {
        super.setUp()
        
        sut = APIService()
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    func testFetchRepositories() {
        let promise = XCTestExpectation(description: "Fetch repositories completed")
        var responseError: Error?
        var responseRepositories: [Repository]?
        
        guard (Bundle.unitTest.path(forResource: "stub", ofType: "json") != nil) else {
            XCTFail("Error: content not found")
            return
        }
        
        sut.fetchRepositories(atPage: 0, completion: { result in
            switch result {
            case .success(let repositories):
                responseRepositories = repositories
            case .failure(let error):
                responseError = error
            }
            promise.fulfill()
        })
        wait(for: [promise], timeout: 1)
        
        XCTAssertNil(responseError)
        XCTAssertNotNil(responseRepositories)
    }
}
