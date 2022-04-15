//
//  RepositoriesTableViewController.swift
//  MATICTask
//
//  Created by Mohamed Maged on 12/04/2022.
//

import UIKit
import Kingfisher

class RepositoriesTableViewController: UITableViewController, UITableViewDataSourcePrefetching {
    private let repositoryViewModel = RepositoryViewModel()
    
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
    
            tableView.reloadData()
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
        tableView.backgroundView = UIImageView(image: UIImage(named: "Background1"))
        tableView.separatorStyle = .none
    }

    // MARK: - Table view prefetch data source
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        repositoryViewModel.prefetchRows(at: indexPaths)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("--------------\(repositoryViewModel.repositoryData.count)")
        return repositoryViewModel.repositoryData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withType: RepositoryTableViewCell.self, for: indexPath)

        cell.selectionStyle = .none
        cell.viewContainer.layer.cornerRadius = cell.viewContainer.frame.height / 15

        let repository = repositoryViewModel.repositoryData[indexPath.row]
        
        let dateComponents = Calendar.current.dateComponents([.day, .weekOfMonth, .month], from: .now, to: repository.updatedAt)
        
        let formatter = RelativeDateTimeFormatter()
        
        var timeInterval = formatter.localizedString(from: dateComponents)

        cell.configureCell(repositoryName: repository.name ?? "", repositoryDescription: repository.description ?? "", username: repository.owner?.login ?? "", avatarURL: repository.owner?.avatarUrl ?? "", numberOfStars: repository.stargazersCount, numberOfIssues: repository.openIssuesCount, updatedDate: timeInterval)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
            if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
                let spinner = UIActivityIndicatorView(style: .medium)
                spinner.startAnimating()
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))

                tableView.tableFooterView = spinner
                tableView.tableFooterView?.isHidden = false
    }
  }
}
