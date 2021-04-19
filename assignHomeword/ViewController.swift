//
//  ViewController.swift
//  assignHomeword
//
//  Created by Sasha Fujiwara on 2021/04/14.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    var datePickerPresented = false
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var assignments: [Assignment] = []
    let datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
     
        tableView.dataSource = self
     
        
        tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assignments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        let currentItem = assignments[indexPath.row]
        cell.textLabel?.text = currentItem.assignmentName
        cell.detailTextLabel?.text = "Due date: \(currentItem.dueDate)"
        return cell
    }

  
    @IBAction func assignItemButton(_ sender: UIBarButtonItem) {
        ///CreateNewAssignment
        print("Registered")
        if let newAssignmentName = textField.text {
            let newAssignment = Assignment(assignmentName: newAssignmentName, dueDate: "")
            assignments.append(newAssignment)
            tableView.reloadData()
            print(newAssignmentName)
            textField.text = newAssignmentName
            
            ///Function called to present datePicker
            createDatePicker()
            
            
    
         
                    

    }
        
        textField.resignFirstResponder()
   
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            assignments.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
        
    }
    
    func createDatePicker(){
        
        print("Function called")
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        datePicker.datePickerMode = .dateAndTime
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolBar.setItems([doneButton], animated: true)
        textField.inputAccessoryView = toolBar
        textField.inputView = datePicker
        

    }
       @objc func donePressed(){
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY, MMM d, hh:mm"
        let theDate = datePicker.date
        let chosenDate = dateFormatter.string(from: theDate)
        print(chosenDate)
        self.view.endEditing(true)
            let assignmentName = textField.text!
            let newAssignment =  Assignment(assignmentName: assignmentName, dueDate: chosenDate)
              assignments.append(newAssignment)
        textField.text = ""
        tableView.reloadData()
             datePicker.resignFirstResponder()
        
        
       
    }

    @IBAction func editButton(_ sender: UIBarButtonItem) {
        if let assignment = tableView.indexPathForSelectedRow {
            let textField = UITextField()
           
            
        }
    }
    
}
