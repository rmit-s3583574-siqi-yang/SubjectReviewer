//
//  SubjectTableViewCell.swift
//  SubjectReviewer
//
//  Created by siqi yang on 14/9/17.
//  Copyright © 2017 siqi yang. All rights reserved.
//

import UIKit

class SubjectTableViewCell: UITableViewCell {
    
    
    //MARK: - Properties
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageDisplay: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    //MARK: - Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
