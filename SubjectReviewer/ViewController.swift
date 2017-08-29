//
//  ViewController.swift
//  SubjectReviewer
//
//  Created by siqi yang on 27/8/17.
//  Copyright © 2017 siqi yang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    //MARK: Properties
    var model = Model()
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var rateTextField: UITextField!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var imageField: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        codeTextField.delegate = self

        // Do any additional setup after loading the view, typically from a nib.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    //MARK: Actions
    @IBAction func addImage(_ sender: UIButton) {
        imageField.image = #imageLiteral(resourceName: "IconI")
    }
    
    @IBAction func getCodeTestValue(_ sender: UITextField) {
        model.addNewCode(code: codeTextField.text!)
    }


    
    @IBAction func getNameTextValue(_ sender: UITextField) {
        model.addNewName(name: nameTextField.text!)
    }
    
    @IBAction func getRateTextValue(_ sender: UITextField) {

        model.addNewRate(rate: rateTextField.text!)
    }
    
    @IBAction func getComTextValue(_ sender: UITextField) {
        model.addNewComment(comment: codeTextField.text!)
    }
    
    @IBAction func saveAsubject(_ sender: UIButton) {
        model.addNewSub()
    }
    
    
    
    


}

