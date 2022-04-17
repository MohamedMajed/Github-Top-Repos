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
    
    

    func testFetchRepositoriesFromAPI() {
        let serviceMock = ServiceMock()
        let sut = RepositoriesViewModel(repositoryService: serviceMock)
       
        // When
        sut.fetchRepositoriesFromAPI()

        // Assert
        XCTAssert(serviceMock.isFetchRepositoriesCalled)
    }
    
    func testRepositoriesViewModelUpdatedSuccessfully() {
        let repo = Repository(id: 1, name: "repoName", owner: nil, description: "", stargazersCount: 2.0, openIssuesCount: 1, createdAt: .now, updatedAt: .now)
        let repositories: [Repository] = [repo, repo, repo]
        let successResult: Result<[Repository]?, Error> = .success(repositories)
        
        let serviceMockWithResult = ServiceMockWithResult(result: successResult)
        let sut = RepositoriesViewModel(repositoryService: serviceMockWithResult)
        
        sut.fetchRepositoriesFromAPI()
        
        XCTAssertEqual(repositories, sut.repositories)
    }
    
    func testRepositoriesViewModelUpdatedFailed() {
        
        let error = NSError(domain: "", code: 1, userInfo: nil)
        let FailedResult: Result<[Repository]?, Error> = .failure(error)
        
        let serviceMockWithResult = ServiceMockWithResult(result: FailedResult)
        let sut = RepositoriesViewModel(repositoryService: serviceMockWithResult)
        
        sut.fetchRepositoriesFromAPI()
        
        XCTAssertEqual(error.localizedDescription, sut.errorMessage)
    }
}
