//
//  RepositoryViewModel.swift
//  MATICTask
//
//  Created by Mohamed Maged on 13/04/2022.
//

import Foundation

class RepositoryViewModel {
    
    var apiService: APIServiceProtocol!
    var repositoryService: APIService!
    var currentPage: Int = 1
    var isFetchingRepositories = false
    var repositoriesData: [Repository] = [] {
        didSet {
            
            self.bindRepositoriesViewModelToView()
        }
    }
    
    var showError: String! {
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
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func prefetchRows(at indexPaths: [IndexPath]) {
        for index in indexPaths {
            if index.row >= repositoriesData.count - 5 && !isFetchingRepositories && currentPage <= 10 {
                fetchRepositoriesFromAPI()
                break
            }
        }
    }
    
    func fetchRepositoriesFromAPI() {
        
        isFetchingRepositories = true
        repositoryService?.fetchRepositories(atPage: currentPage) { result in
            switch result {
            case .success(let repositories):
                print("Page Number : \(self.currentPage)")
                if self.currentPage <= 10 {
                    self.repositoriesData.append(contentsOf: repositories ?? [])
                    self.currentPage += 1
                }
            case .failure(let error):
                let message = error.localizedDescription
                self.showError = message
                print(error.localizedDescription)
            }
            self.isFetchingRepositories = false
        }
    }
}

