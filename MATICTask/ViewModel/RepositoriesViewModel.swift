//
//  RepositoryViewModel.swift
//  MATICTask
//
//  Created by Mohamed Maged on 13/04/2022.
//

import Foundation

class RepositoriesViewModel {
    
    var repositoryService: RepositoriesService
    var currentPage: Int = 1
    var isFetchingRepositories = false
    var repositories: [Repository] = [] {
        didSet {
            
            self.bindRepositoriesViewModelToView()
        }
    }
    
    var errorMessage: String = "" {
        didSet {
            
            self.bindViewModelErrorToView()
        }
    }
    
    var bindRepositoriesViewModelToView: (()->()) = {}
    var bindViewModelErrorToView: (()->()) = {}
    
    init() {
        self.repositoryService = APIService()
        self.fetchRepositoriesFromAPI()
    }
    
    init(repositoryService: RepositoriesService = APIService()) {
        self.repositoryService = repositoryService
    }
    
    func prefetchRows(at indexPaths: [IndexPath]) {
        for index in indexPaths {
            if index.row >= repositories.count - 20 && !isFetchingRepositories && currentPage <= 10 {
                fetchRepositoriesFromAPI()
                break
            }
        }
    }
    
    func fetchRepositoriesFromAPI() {
        
        isFetchingRepositories = true
        repositoryService.fetchRepositories(atPage: currentPage) { result in
            switch result {
            case .success(let repositoriesResponse):
                print("Page Number : \(self.currentPage)")
                if self.currentPage <= 10 {
                    self.repositories.append(contentsOf: repositoriesResponse.items ?? [])
                    self.currentPage += 1
                }
            case .failure(let error):
                let message = error.localizedDescription
                self.errorMessage = message
                print(error.localizedDescription)
            }
            self.isFetchingRepositories = false
        }
    }
}

