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
    var model = Model.sharedInstance
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var imageField: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    private var currentTextField: UITextField?
    
    var imageName: String = "A"
    var currentSubject: Subjects?
    
    
    //MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        codeTextField.delegate = self
        nameTextField.delegate = self
        commentTextField.delegate = self
        
        
        updateSaveButtonState()
        
        
        
        print("the picked Subject index is: ",ShowSubjectViewController.selectedSubject ?? 0)
        
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
        
        // Do any additional setup after loading the view, typically from a nib.
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
    
    //MARK: - Actions
    @IBAction func unwindToAddSubject(sender: UIStoryboardSegue) {
        
        imageName = Image.image[ImageCollectionViewController.seletedIconIndex]
        imageField.image = UIImage(named: imageName)
//        // check whether a row in the table view is selected
//        if let selectedIndexPath = tableView.indexPathForSelectedRow {
//            // Update an existing subject.
//            model.editSub(index: selectedIndexPath.row)
//            tableView.reloadRows(at: [selectedIndexPath], with: .none)
//        }
//        else {
//            // Add a new subject.
//            model.addNewSub()
//            let newIndexPath = IndexPath(row: model.manySubjects.count-1, section: 0)
//            tableView.insertRows(at: [newIndexPath], with: .right)
//            
//        }
        
    }
    
    
    //    // This method lets you configure a view controller before it's presented.
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //
    //
    //        if let currentTextField = currentTextField {
    //            currentTextField.resignFirstResponder()
    //        }
    //
    //        // Configure the destination view controller only when the save button is pressed.
    //        guard let button = sender as? UIBarButtonItem, button === saveButton else {
    //            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
    //            return
    //        }
    //
    //        model.saveSubject(codeTextField.text!, name: nameTextField.text!, rate: ratingControl.rating, comment: commentTextField.text!, image: imageName, existing: currentSubject)
    //
    //    }
    
    //    //MARK: - Actions
    //    @IBAction func addImage(_ sender: UIButton) {
    //
    //        // Load Head Letter Images
    //
    //        imageField.image = #imageLiteral(resourceName: "A")//Image.image[0]
    //        model.addNewImage(image: #imageLiteral(resourceName: "A"))
    //    }
    
    
}

