//
//  ImageCollectionViewCell.swift
//  SubjectReviewer
//
//  Created by siqi yang on 1/10/17.
//  Copyright © 2017 siqi yang. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    //@IBOutlet var image: UIImageView!
    @IBOutlet weak var image: UIImageView!

    //MARK: - Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)
    }
 
}
