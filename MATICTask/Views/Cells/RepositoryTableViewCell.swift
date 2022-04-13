//
//  RepositoryTableViewCell.swift
//  MATICTask
//
//  Created by Mohamed Maged on 12/04/2022.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var ownerImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var repositoryDescriptionLabel: UILabel!
    @IBOutlet weak var numberOfStarsLabel: UILabel!
    @IBOutlet weak var numberOfIssuesLabel: UILabel!
    @IBOutlet weak var timeIntervalLabel: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addShadowToImageContainer()
        addShadowToOwnerImage()
        viewContainer.backgroundColor = UIColor.gray.withAlphaComponent(0.75)
        viewContainer.isOpaque = false
        viewContainer.layer.shadowColor = UIColor.gray.cgColor
        viewContainer.layer.shadowOpacity = 1.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    // MARK: - Configure Table view cell
    
    func configureCell(repositoryName: String, repositoryDescription: String, username: String, avatarURL: String, numberOfStars: Double, numberOfIssues: Int){
        
        repositoryNameLabel.text = repositoryName
        repositoryDescriptionLabel.text = repositoryDescription
        usernameLabel.text = username
        numberOfStarsLabel.text = (String((numberOfStars)/1000.0) + "K ⭐")
        numberOfIssuesLabel.text = String(numberOfIssues)
        let url = URL(string: avatarURL)
        ownerImageView.kf.setImage(with: url)
    }
    
    func addShadowToImageContainer() {
        imageContainer.layer.backgroundColor = UIColor.white.cgColor
        imageContainer.layer.shadowColor = UIColor.black.cgColor
        imageContainer.layer.shadowOpacity = 0.3
        imageContainer.layer.masksToBounds = false
        imageContainer.layer.shadowOffset = .zero
        imageContainer.layer.shadowRadius = 3
        imageContainer.layer.cornerRadius = 55
        imageContainer.layer.backgroundColor = UIColor.gray.cgColor
    }
   
    func addShadowToOwnerImage() {
        ownerImageView.layer.shadowOpacity = 1
        ownerImageView.layer.shadowRadius = 7
        ownerImageView.layer.cornerRadius = 52.5
    }
}
