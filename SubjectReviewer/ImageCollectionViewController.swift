//
//  ImageCollectionViewController.swift
//  SubjectReviewer
//
//  Created by siqi yang on 1/10/17.
//  Copyright © 2017 siqi yang. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ImageCollectionViewCell"

class ImageCollectionViewController: UICollectionViewController {
    
    //MARK: - Properties
    static var seletedIconIndex = 0
    
    //MARK: - overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let selectedIconCell = sender as? ImageCollectionViewCell else {
            fatalError("Unexpected sender: ")
        }
        
        guard let indexPath = collectionView?.indexPath(for: selectedIconCell) else {
            fatalError("The selected cell is not being displayed by the table")
        }
        
        // Pass the selected Subject Index to ShowSubjectViewController
        let selectedIcon = indexPath.row
        
        ImageCollectionViewController.seletedIconIndex = selectedIcon
    }
    
    
    // MARK: - UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 26
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        
        cell.image.image = UIImage(named: Image.image[indexPath.row])
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.gray.cgColor
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
}
