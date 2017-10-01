//
//  ImageCollectionViewCell.swift
//  SubjectReviewer
//
//  Created by siqi yang on 1/10/17.
//  Copyright © 2017 siqi yang. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var image: UIImageView!

    var icon: [UIImage] = [#imageLiteral(resourceName: "A"),#imageLiteral(resourceName: "B"),#imageLiteral(resourceName: "C"),#imageLiteral(resourceName: "D"),#imageLiteral(resourceName: "E"),#imageLiteral(resourceName: "F"),#imageLiteral(resourceName: "G"),#imageLiteral(resourceName: "H"),#imageLiteral(resourceName: "I"),#imageLiteral(resourceName: "J"),#imageLiteral(resourceName: "K"),#imageLiteral(resourceName: "L"),#imageLiteral(resourceName: "M"),#imageLiteral(resourceName: "N"),#imageLiteral(resourceName: "O"),#imageLiteral(resourceName: "P"),#imageLiteral(resourceName: "Q"),#imageLiteral(resourceName: "R"),#imageLiteral(resourceName: "S"),#imageLiteral(resourceName: "T"),#imageLiteral(resourceName: "U"),#imageLiteral(resourceName: "V"),#imageLiteral(resourceName: "W"),#imageLiteral(resourceName: "X"),#imageLiteral(resourceName: "Y"),#imageLiteral(resourceName: "Z")]
    //                      0   1   2   3   4   5   6   7   8   9   10  11 12  13  14  15  16  17  18  19  20  21  22  23  24  25
    
    
    //MARK: - Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func setimage(_ item:Int){
        
        
        image?.image = icon[item]
    }
    
}
