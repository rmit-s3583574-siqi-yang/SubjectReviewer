//
//  AddSubjectViewController.swift
//  SubjectReviewer
//
//  Created by siqi yang on 27/8/17.
//  Copyright © 2017 siqi yang. All rights reserved.
//

import UIKit
import os.log

class AddSubjectViewController: UIViewController, UITextFieldDelegate {
    //MARK: - Properties
    var user = User.sharedInstance
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var imageField: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    private var currentTextField: UITextField?
    
    
    //MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        codeTextField.delegate = self
        nameTextField.delegate = self
        commentTextField.delegate = self
        
        
        updateSaveButtonState()
        
        
        print("the picked Subject index is: ",ShowSubjectViewController.selectedSubject ?? 0)
        
        if ShowSubjectViewController.selectedSubject != nil  {
            navigationItem.title = user.manySubjects[ShowSubjectViewController.selectedSubject!].getSubjectInforName()
            codeTextField.text = user.manySubjects[ShowSubjectViewController.selectedSubject!].getSubjectInforCode()
            nameTextField.text = user.manySubjects[ShowSubjectViewController.selectedSubject!].getSubjectInforName()
            commentTextField.text = user.manySubjects[ShowSubjectViewController.selectedSubject!].getSubjectInforComment()
            imageField.image = user.manySubjects[ShowSubjectViewController.selectedSubject!].getSubjectInforImage()
            ratingControl.rating = user.manySubjects[ShowSubjectViewController.selectedSubject!].getSubjectInforRate()
        }
        
        updateSaveButtonState()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidLayoutSubviews()
    {
        //print("viewDidLayoutSubviews. \(ratingControl)");
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
    
    
    
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if let currentTextField = currentTextField {
            currentTextField.resignFirstResponder()
        }
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        user.addNewCode(code: codeTextField.text!)
        user.addNewName(name: nameTextField.text!)
        user.addNewComment(comment: commentTextField.text!)
        user.addNewRate(rate: ratingControl.rating)
        
        
        
        
    }
    
//    //MARK: - Actions
//    @IBAction func addImage(_ sender: UIButton) {
//        
//        // Load Head Letter Images
//        
//        imageField.image = #imageLiteral(resourceName: "A")//Image.image[0]
//        model.addNewImage(image: #imageLiteral(resourceName: "A"))
//    }
    
    
}

