//
//  AddSubjectViewController.swift
//  SubjectReviewer
//
//  Created by siqi yang on 27/8/17.
//  Copyright © 2017 siqi yang. All rights reserved.
//

import UIKit

class AddSubjectViewController: UIViewController, UITextFieldDelegate {
    //MARK: - Properties
    var model = Model.sharedInstance
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var imageField: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        codeTextField.delegate = self

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
    

    
    //MARK: - Actions
    @IBAction func addImage(_ sender: UIButton) {
        
        // Load Head Letter Images
        
        let A = UIImage(named: "A")
        imageField.image = A
        model.addNewImage(image: A!)
    }
    
    @IBAction func getCodeTestValue(_ sender: UITextField) {
        model.addNewCode(code: codeTextField.text!)
    }


    
    @IBAction func getNameTextValue(_ sender: UITextField) {
        model.addNewName(name: nameTextField.text!)
    }
    
    
    
//    @IBAction func getRateTextValue(_ sender: UITextField) {
//
//        model.addNewRate(rate: String(ratingControl.rating))
//    }
    
    @IBAction func getComTextValue(_ sender: UITextField) {
        model.addNewComment(comment: commentTextField.text!)
    }
    
    @IBAction func saveAsubject(_ sender: UIButton) {
        model.addNewCode(code: codeTextField.text!)
        model.addNewName(name: nameTextField.text!)
        model.addNewComment(comment: commentTextField.text!)
        model.addNewRate(rate: ratingControl.rating)
        model.addNewSub()
    }
    
    
    
    


}

