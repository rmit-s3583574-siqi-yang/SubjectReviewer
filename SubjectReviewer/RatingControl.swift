//
//  RatingControl.swift
//  SubjectReviewer
//
//  Created by siqi yang on 18/9/17.
//  Copyright © 2017 siqi yang. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    //MARK: - Properties
    @IBInspectable var starSize: CGSize = CGSize(width: 40.0, height: 40.0){
        didSet{
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet{
            setupButtons()
        }
    }
    
    private var ratingButtons = [UIButton]()
    
    var rating = 0{
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    
    }
    
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //MARK: - Button Action
    func ratingButtonTapped(button: UIButton) {
        
        guard let index = ratingButtons.index(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        // Calculate the rating of the selected button
        let selectedRating = index + 1
        
        if selectedRating == rating {
            // If the selected star represents the current rating, reset the rating to 0.
            rating = 0
        } else {
            // Otherwise set the rating to the selected star
            rating = selectedRating
        }
    }
        
    
    //MARK: - Private Methods
    
    private func setupButtons(){
        
        
        //print("setupButton. \(self)");
        
        

        
        // Remove all buttons in the last setups
        for button in ratingButtons{
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        // Load Button Images
        let bundle = Bundle(for: type(of: self))
        let StarFill = UIImage(named: "StarFill", in: bundle, compatibleWith: self.traitCollection)
        let StarEmpty = UIImage(named:"StarEmpty", in: bundle, compatibleWith: self.traitCollection)
        let StarHighL = UIImage(named:"StarHighL", in: bundle, compatibleWith: self.traitCollection)

        
        for index in 0..<starCount {
            
            //Create a button
            let button = UIButton()
            
            //Set button image
            button.setImage(StarEmpty, for: .normal)
            button.setImage(StarFill, for: .selected)
            button.setImage(StarHighL, for: .highlighted)
            button.setImage(StarHighL, for: [.highlighted, .selected])
            
            //Add constraints
            button.translatesAutoresizingMaskIntoConstraints = true
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            // Set the accessibility label
            button.accessibilityLabel = "Set \(index + 1) star rating"
            
            // Setup the button action
            button.addTarget(self, action:
                #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            // Add the button to the stack
            addArrangedSubview(button)
            
            ratingButtons.append(button)
        }
        
        updateButtonSelectionStates()
    
    }
    
    private func updateButtonSelectionStates() {
        
        for (index, button) in ratingButtons.enumerated() {
            // If the index of a button is less than the rating, that button should be selected.
            button.isSelected = index < rating
            
            // Set the hint String and value
            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap to reset the rating to zero."
            } else {
                hintString = nil
            }
            
            // Calculate the value string
            let valueString: String
            switch (rating) {
            case 0:
                valueString = "No rating set."
            case 1:
                valueString = "1 star set."
            default:
                valueString = "\(rating) stars set."
            }
            
            // Assign the hint string and value string
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }


}
