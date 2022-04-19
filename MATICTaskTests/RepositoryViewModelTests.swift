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
        let repo = Repository(id: 1, name: "repoName", owner: nil, description: "", stargazersCount: 2.0, openIssuesCount: 1, updatedAt: .now, htmlUrl: URL(string: ""))
        let repositories: [Repository] = [repo, repo, repo]
        let repos: RepositoryResponse = RepositoryResponse.init(totalCount: 1, incompleteResults: true, items: repositories)
        let successResult: Result<RepositoryResponse, Error> = .success(repos)
        
        let serviceMockWithResult = ServiceMockWithResult(result: successResult)
        let sut = RepositoriesViewModel(repositoryService: serviceMockWithResult)
        
        sut.fetchRepositoriesFromAPI()
        
        XCTAssertEqual(repositories, sut.repositories)
    }
    
    func testRepositoriesViewModelUpdatedFailed() {
        
        let error = NSError(domain: "", code: 1, userInfo: nil)
        let FailedResult: Result<RepositoryResponse, Error> = .failure(error)
        
        let serviceMockWithResult = ServiceMockWithResult(result: FailedResult)
        let sut = RepositoriesViewModel(repositoryService: serviceMockWithResult)
        
        sut.fetchRepositoriesFromAPI()
        
        XCTAssertEqual(error.localizedDescription, sut.errorMessage)
    }
}
