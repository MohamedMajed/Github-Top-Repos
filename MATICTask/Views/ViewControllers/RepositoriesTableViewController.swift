//
//  RepositoriesTableViewController.swift
//  MATICTask
//
//  Created by Mohamed Maged on 12/04/2022.
//

import UIKit
import Kingfisher

class RepositoriesTableViewController: UITableViewController, UITableViewDataSourcePrefetching {
    var repositories: [Repository] = [Repository]()
    let repositoryViewModel = RepositoryViewModel()
//    var currentPage: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        subscribeToViewModelEvents()
    }
  
    func subscribeToViewModelEvents() {
        
        repositoryViewModel.bindRepositoriesViewModelToView = {
            
            self.onSuccessUpdateView()
        }
        
        repositoryViewModel.bindViewModelErrorToView = {
            
            self.onFailUpdateView()
        }
    }
    
    // MARK: - Update Table view
    
    func onSuccessUpdateView() {
        
        repositories = repositoryViewModel.repositoryData
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.repositoryViewModel.currentPage += 1
            self.repositoryViewModel.isFetchingRepositories = false
        }
    }
    
    func onFailUpdateView() {
        
        let alert = UIAlertController(title: "Error 404", message: repositoryViewModel.showError, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .default) {
            (UIAlertAction) in
            
        }
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Configure Table view
    
    func configureTableView() {
        
        tableView.register(cellType: RepositoryTableViewCell.self)
        tableView.prefetchDataSource = self
        tableView.backgroundView = UIImageView(image: UIImage(named: "Background2"))
        tableView.separatorStyle = .none
    }

    // MARK: - Table view prefetch data source
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        for index in indexPaths {
            if index.row >= repositories.count - 5 && !repositoryViewModel.isFetchingRepositories {
                repositoryViewModel.getRepositoriesFromAPI()
                break
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return repositories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withType: RepositoryTableViewCell.self, for: indexPath)

        cell.selectionStyle = .none
        cell.viewContainer.layer.cornerRadius = cell.viewContainer.frame.height / 15

        let repository = repositoryViewModel.repositoryData[indexPath.row]

        cell.configureCell(repositoryName: repository.name, repositoryDescription: repository.description ?? "", username: repository.owner?.login ?? "", avatarURL: repository.owner?.avatarUrl ?? "", numberOfStars: repository.stargazersCount, numberOfIssues: repository.openIssuesCount)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.4) {
            cell.transform = CGAffineTransform.identity
        }
    }
}
