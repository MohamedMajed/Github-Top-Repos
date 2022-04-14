//
//  RepositoryViewModel.swift
//  MATICTask
//
//  Created by Mohamed Maged on 13/04/2022.
//

import Foundation

class RepositoryViewModel: NSObject{
    
    var repositoryService:RepositoryService!
    var currentPage: Int = 1
    var isFetchingRepositories = false
    var repositoryData:[Repository]! {
        didSet{
            
            self.bindRepositoriesViewModelToView()
        }
    }
    
    var showError: String!{
        didSet{
            
            self.bindViewModelErrorToView()
        }
    }
    
    var bindRepositoriesViewModelToView: (()->()) = {}
    var bindViewModelErrorToView: (()->()) = {}
    
    override init() {
        
        super .init()
        self.repositoryService = RepositoryService()
        self.getRepositoriesFromAPI()
    }  
    
    func getRepositoriesFromAPI(){
        isFetchingRepositories = true
        repositoryService.fetchRepositories(atPage: currentPage, completion: { (repositoryData, error) in
            if let error = error {
                
                let message = error.localizedDescription
                self.showError = message
                
            }else{
                print("Page Number : \(self.currentPage)")
                self.repositoryData = repositoryData
//                self.currentPage += 1
//                self.isFetchingRepositories = false
            }
        })
    }
    
}
