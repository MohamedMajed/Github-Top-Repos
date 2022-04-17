//
//  ServiceMockWithResult.swift
//  MATICTaskTests
//
//  Created by Mohamed Maged on 18/04/2022.
//

import Foundation
@testable import MATICTask

class ServiceMockWithResult: RepositoriesService {
    let result: Result<[Repository]?, Error>
    
    init(result: Result<[Repository]?, Error>) {
        
        self.result = result
    }
    
    func fetchRepositories(atPage: Int, completion: @escaping (Result<[Repository]?, Error>) -> Void) {
     
        completion(result)
    }

}
