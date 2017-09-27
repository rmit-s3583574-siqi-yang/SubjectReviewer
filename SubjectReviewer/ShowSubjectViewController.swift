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
        showImage.image = model.manySubjects[ShowSubjectViewController.selectedSubject!].getSubjectInforImage()
        showNameLabel.text = model.manySubjects[ShowSubjectViewController.selectedSubject!].getSubjectInforName()
        showRating.rating = model.manySubjects[ShowSubjectViewController.selectedSubject!].getSubjectInforRate()
        showComment.text = model.manySubjects[ShowSubjectViewController.selectedSubject!].getSubjectInforComment()
        navigationItem.title = model.manySubjects[ShowSubjectViewController.selectedSubject!].getSubjectInforCode()
        
        // Do any additional setup after loading the view.
        
        
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
