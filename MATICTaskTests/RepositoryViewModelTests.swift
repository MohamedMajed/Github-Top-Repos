//
//  RepositoryViewModelTests.swift
//  MATICTaskTests
//
//  Created by Mohamed Maged on 17/04/2022.
//

import Foundation
import XCTest
@testable import MATICTask

class RepositoryViewModelTests: XCTestCase {
    var sut: RepositoryViewModel!
    var apiSeviceMock: APIServiceMock!
    
    
    override func setUp() {
        super.setUp()
        apiSeviceMock = APIServiceMock()
        sut = RepositoryViewModel(apiService: apiSeviceMock)
    }
    
    override func tearDown() {
        sut = nil
        apiSeviceMock = nil
        super.tearDown()
    }
    
    func testFetchRepositoriesFromAPI() {
        
        // Given
        apiSeviceMock.completeRepositories = [Repository]()

        // When
        sut.fetchRepositoriesFromAPI()
    
        // Assert
        XCTAssert(apiSeviceMock!.isFetchRepositoriesCalled)
        
    }
    
}
