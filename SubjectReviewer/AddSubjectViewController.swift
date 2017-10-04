//
//  AddSubjectViewController.swift
//  SubjectReviewer
//
//  Created by siqi yang on 27/8/17.
//  Copyright © 2017 siqi yang. All rights reserved.
//

import UIKit
import os.log

class AddSubjectViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    //MARK: - Properties
    var model = Model.sharedInstance
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var commentTextField: UITextView!
    @IBOutlet weak var imageField: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    private var currentTextField: UITextField?
    
    private var duplicateSub: Bool = false
    
    var imageName: String = "A"
    var currentSubject: Subjects?
    
    
    //MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // initiate delegates
        codeTextField.delegate = self
        nameTextField.delegate = self
        commentTextField.delegate = self
        
        updateSaveButtonState()
        // Set the border color of UITextView of comment
        let myColor = UIColor.init(white: 0.1, alpha: 0.1)
        commentTextField.layer.borderColor = myColor.cgColor
        commentTextField.layer.borderWidth = 1.0
        
        // Set up view if a table cell is picked
        if ShowSubjectViewController.selectedSubject != nil  {
            navigationItem.title = model.subjectDB[ShowSubjectViewController.selectedSubject!].name
            codeTextField.text = model.subjectDB[ShowSubjectViewController.selectedSubject!].code
            nameTextField.text = model.subjectDB[ShowSubjectViewController.selectedSubject!].name
            commentTextField.text = model.subjectDB[ShowSubjectViewController.selectedSubject!].comment
            imageName = model.subjectDB[ShowSubjectViewController.selectedSubject!].image!
            imageField.image = UIImage(named: imageName)
            ratingControl.rating = Int(model.subjectDB[ShowSubjectViewController.selectedSubject!].rate)
            currentSubject = model.subjectDB[ShowSubjectViewController.selectedSubject!]
        }
        
        updateSaveButtonState()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK: - UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
        updateSaveButtonState()
        currentTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = nameTextField.text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // User finished typing (hit return): hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    
    //MARK: - Private Methods
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let codeText = codeTextField.text ?? ""
        let nameText = nameTextField.text ?? ""
        let commentText = commentTextField.text ?? ""
        saveButton.isEnabled = !(codeText.isEmpty || nameText.isEmpty || commentText.isEmpty)
        
    }
    
    
    //MARK: - Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        model.getSubjects()
        if ShowSubjectViewController.selectedSubject == nil{
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("oops")
        }
    }
    
    
    
    //MARK: - Actions
    @IBAction func saveSubject(_ sender: UIBarButtonItem) {
        
        model.saveSubject(codeTextField.text!, name: nameTextField.text!, rate: ratingControl.rating, comment: commentTextField.text!, image: imageName, existing: currentSubject)
        
        if Model.DuplicateSubject == true {
            
            let alertController = UIAlertController(title: "Error", message: "Subject is Already Exist", preferredStyle: .alert)
            let cancelButton = UIAlertAction(title: "OK", style: .cancel, handler: { (action) -> Void in
            })
            alertController.addAction(cancelButton)
            self.navigationController!.present(alertController, animated: true, completion: nil)
            
        }else{
            model.getSubjects()
            
            if ShowSubjectViewController.selectedSubject == nil{
                dismiss(animated: true, completion: nil)
            }
            else if let owningNavigationController = navigationController{
                owningNavigationController.popViewController(animated: true)
            }
            else {
                fatalError("oops")
            }
            model.getSubjects()
        }
    }
    
    
    // returned from other segue
    @IBAction func unwindToAddSubject(sender: UIStoryboardSegue) {
        
        imageName = Image.image[ImageCollectionViewController.seletedIconIndex]
        imageField.image = UIImage(named: imageName)
    }
}

