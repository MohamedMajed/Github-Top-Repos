//
//  RepositoryTableViewCell.swift
//  MATICTask
//
//  Created by Mohamed Maged on 12/04/2022.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var ownerImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var repositoryDescriptionLabel: UILabel!
    @IBOutlet weak var numberOfStars: UILabel!
    @IBOutlet weak var numberOfIssues: UILabel!
    @IBOutlet weak var timeIntervalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
