//
//  ShowSubjectViewController.swift
//  SubjectReviewer
//
//  Created by siqi yang on 22/9/17.
//  Copyright © 2017 siqi yang. All rights reserved.
//

import UIKit

class ShowSubjectViewController: UIViewController {
    
    
    //MARK: - Properties
    var model = Model.sharedInstance
    static var selectedSubject: Int? = nil
    
    
    
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var showNameLabel: UILabel!
    @IBOutlet weak var showRating: RatingControl!
    @IBOutlet weak var showComment: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add Subject Infor to View
        showImage.image = UIImage(named: model.subjectDB[ShowSubjectViewController.selectedSubject!].image!)
        showNameLabel.text = model.subjectDB[ShowSubjectViewController.selectedSubject!].name
        showRating.rating = Int(model.subjectDB[ShowSubjectViewController.selectedSubject!].rate)
        showComment.text = model.subjectDB[ShowSubjectViewController.selectedSubject!].comment
        navigationItem.title = model.subjectDB[ShowSubjectViewController.selectedSubject!].code

    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Actions
    
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

