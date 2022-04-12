//
//  RepositoryViewModel.swift
//  MATICTask
//
//  Created by Mohamed Maged on 13/04/2022.
//

import Foundation

class RepositoryViewMode: NSObject{
    
    var repositoryService:RepositoryService!
    var repositoryData:[Repository]{
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
        
        repositoryService.getRepositories(completion: { (repositoryData, error) in
            if let error = error {
                
                let message = error.localizedDescription
                self.showError = message
                
            }else{
                
                self.repositoryData = repositoryData
            }
        })
    }
    
}
