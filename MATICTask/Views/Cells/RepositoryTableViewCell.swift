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
        updateImageContainer()
        updateOwnerImage()
        updateViewContainer()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    // MARK: - Configure Table view cell
    
    func configureCell(repositoryName: String, repositoryDescription: String, username: String, avatarURL: String, numberOfStars: Double, numberOfIssues: Int, updatedDate: Date) {
        
        repositoryNameLabel.text = repositoryName
        repositoryDescriptionLabel.text = repositoryDescription
        usernameLabel.text = username
        numberOfStarsLabel.text = (String(format: "%.1f", (numberOfStars)/1000.0) + "K ⭐")
        numberOfIssuesLabel.text = String(numberOfIssues) + " 🔴"
        
        let url = URL(string: avatarURL)
        ownerImageView.kf.setImage(with: url)
        
        let dateComponents = Calendar.current.dateComponents([.hour, .day, .weekOfMonth, .month], from: .now, to: updatedDate)
        let formatter = RelativeDateTimeFormatter()
        let timeInterval = formatter.localizedString(from: dateComponents)
        timeIntervalLabel.text = timeInterval
        
    }
    
    func updateImageContainer() {
        
        imageContainer.backgroundColor = UIColor.white.withAlphaComponent(0.50)
        imageContainer.layer.cornerRadius = 55

    }
   
    func updateOwnerImage() {
        
        ownerImageView.layer.cornerRadius = 52.5
    }
    
    func updateViewContainer() {
        
        viewContainer.layer.cornerRadius = viewContainer.frame.height / 15
        viewContainer.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        viewContainer.isOpaque = false
        viewContainer.layer.shadowColor = UIColor.darkGray.cgColor
        viewContainer.layer.shadowOpacity = 0.8
    }
}
