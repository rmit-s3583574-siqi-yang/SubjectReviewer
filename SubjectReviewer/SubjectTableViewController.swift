//
//  SubjectTableViewController.swift
//  SubjectReviewer
//
//  Created by siqi yang on 21/9/17.
//  Copyright © 2017 siqi yang. All rights reserved.
//

import UIKit
import os.log

class SubjectTableViewController: UITableViewController {
    
    //MARK: - Properties
    var model = Model.sharedInstance

    
    //MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        model.getSubjects()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return model.subjectDB.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "SubjectTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SubjectTableViewCell else {
            // Add a new Subject.
            fatalError("The dequeued cell is not an instance of SubjectTableViewCell.")
        }
        
        let sub = model.getSubject(indexPath)
        
        //cell
        cell.nameLabel.text = sub.name
        cell.codeLabel.text = sub.code
        cell.imageDisplay.image = UIImage(named: sub.image!)
        cell.ratingControl.rating = Int(sub.rate)

        return cell
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            model.deleteSubject(model.subjectDB[indexPath.row])
            model.subjectDB.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            model.getSubjects()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
        case "AddSubject":
            os_log("Adding a new Subject.", log: OSLog.default, type: .debug)
            ShowSubjectViewController.selectedSubject = nil
            
        case "ShowDetail":

            guard let selectedSubjectCell = sender as? SubjectTableViewCell else {
                fatalError("Unexpected sender: ")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedSubjectCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            // Pass the selected Subject Index to ShowSubjectViewController
            let selectedSubject = indexPath.row
            
            ShowSubjectViewController.selectedSubject = selectedSubject
            
        default:
            fatalError("Unexpected Segue Identifier;")
            
        }

    }
     
}
