//
//  RepositoriesTableViewController.swift
//  MATICTask
//
//  Created by Mohamed Maged on 12/04/2022.
//

import UIKit
import Kingfisher

class RepositoriesTableViewController: UITableViewController {
    
    var repositories: [Repository] = [Repository]()
    let repositoryViewModel = RepositoryViewMode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(cellType: RepositoryTableViewCell.self)
        tableView.backgroundView = UIImageView(image: UIImage(named: "Background1"))
        tableView.separatorStyle = .none
        
        
        repositoryViewModel.bindRepositoriesViewModelToView = {
            
            self.onSuccessUpdateView()
        }
        
        repositoryViewModel.bindViewModelErrorToView = {
            
            self.onFailUpdateView()
        }
    }
    
    func onSuccessUpdateView(){
        
        repositories = repositoryViewModel.repositoryData
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func onFailUpdateView(){
        
        let alert = UIAlertController(title: "Error 404", message: repositoryViewModel.showError, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .default) {
            (UIAlertAction) in
            
        }
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
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

        cell.repositoryNameLabel.text = repositoryViewModel.repositoryData[indexPath.row].name
        cell.repositoryDescriptionLabel.text = repositoryViewModel.repositoryData[indexPath.row].description
        cell.numberOfStars.text = String((repositoryViewModel.repositoryData[indexPath.row].stargazersCount)/1000.0) + "K ⭐"
        cell.numberOfIssues.text = String(repositoryViewModel.repositoryData[indexPath.row].openIssuesCount)
        cell.usernameLabel.text = repositoryViewModel.repositoryData[indexPath.row].owner?.login
        let url = URL(string: repositoryViewModel.repositoryData[indexPath.row].owner?.avatarUrl ?? "")
        cell.ownerImageView.kf.setImage(with: url)
        
        cell.viewContainer.layer.cornerRadius = cell.viewContainer.frame.height / 5
    
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 140
//    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.4) {
            cell.transform = CGAffineTransform.identity
        }
    }
}
