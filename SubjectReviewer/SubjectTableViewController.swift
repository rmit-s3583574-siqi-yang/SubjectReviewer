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
    var sampleData = DataNotNull()
    
    //MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if model.manySubjects.count == 0 {
            sampleData.setData()
        }
        
        for eachSubject in 0..<model.manySubjects.count {
            print(model.manySubjects[eachSubject].getSubjectInforCode())
            print(model.manySubjects[eachSubject].getSubjectInforName())
            print(model.manySubjects[eachSubject].getSubjectInforRate())
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
         //Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
        
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
        return model.manySubjects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "SubjectTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SubjectTableViewCell else {
            // Add a new Subject.
            fatalError("The dequeued cell is not an instance of SubjectTableViewCell.")
            
            
        }
        
        let subject = model.manySubjects[indexPath.row]
        
        
        // Configurate cell
        cell.nameLabel.text = subject.getSubjectInforName()
        cell.codeLabel.text = subject.getSubjectInforCode()
        cell.imageDisplay.image = subject.getSubjectInforImage()
        cell.ratingControl.rating = subject.getSubjectInforRate()
        
        return cell
    }
    
    //MARK: - Actions
    @IBAction func unwindToSubjectList(sender: UIStoryboardSegue) {
        
        // check whether a row in the table view is selected
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            // Update an existing subject.
            model.editSub(index: selectedIndexPath.row)
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
        }
        else {
            // Add a new subject.
            model.addNewSub()
            let newIndexPath = IndexPath(row: model.manySubjects.count-1, section: 0)
            tableView.insertRows(at: [newIndexPath], with: .right)
            
        }
        
        
        
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
        model.manySubjects.remove(at: indexPath.row)
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
 
    
    
//     // Override to support rearranging the table view.
//     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//     
//     }
// 
//    
//    
//     // Override to support conditional rearranging of the table view.
//     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//     // Return false if you do not want the item to be re-orderable.
//     return true
//     }
 
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
        case "AddSubject":
            os_log("Adding a new Subject.", log: OSLog.default, type: .debug)
            ShowSubjectViewController.selectedSubject = nil
            
        case "ShowDetail":
            
            //            guard let destinationNavigationController = segue.destination as? UINavigationController else{
            //                fatalError("Unexpected destination: \(segue.destination)")
            //            }
            
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
}
