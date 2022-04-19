//
//  ServiceMockWithResult.swift
//  MATICTaskTests
//
//  Created by Mohamed Maged on 18/04/2022.
//

import Foundation
@testable import MATICTask

class ServiceMockWithResult: RepositoriesService {
    func fetchRepositories(atPage: Int, completion: @escaping (Result<RepositoryResponse, Error>) -> Void) {
        completion(result)
    }
    
    let result: Result<RepositoryResponse, Error>
    
    init(result: Result<RepositoryResponse, Error>) {
        
        self.result = result
    }
}
