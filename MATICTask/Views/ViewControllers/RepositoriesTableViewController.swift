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
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryTableViewCell", for: indexPath) as! RepositoryTableViewCell

        cell.repositoryNameLabel.text = repositoryViewModel.repositoryData[indexPath.row].name
        cell.repositoryDescriptionLabel.text = repositoryViewModel.repositoryData[indexPath.row].description
        cell.numberOfStars.text = String(repositoryViewModel.repositoryData[indexPath.row].stargazersCount)
        cell.numberOfIssues.text = String(repositoryViewModel.repositoryData[indexPath.row].openIssuesCount)
        cell.usernameLabel.text = repositoryViewModel.repositoryData[indexPath.row].owner?.login
        let url = URL(string: repositoryViewModel.repositoryData[indexPath.row].owner?.avatarUrl ?? "")
        cell.ownerImageView.kf.setImage(with: url)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
