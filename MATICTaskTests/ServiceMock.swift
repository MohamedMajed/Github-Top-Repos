//
//  APIServiceMock.swift
//  MATICTaskTests
//
//  Created by Mohamed Maged on 16/04/2022.
//

import Foundation
@testable import MATICTask

class ServiceMock: RepositoriesService {
    
    var isFetchRepositoriesCalled = false
    
    func fetchRepositories(atPage: Int, completion: @escaping (Result<[Repository]?, Error>) -> Void) {
     
        isFetchRepositoriesCalled = true
    }

}
