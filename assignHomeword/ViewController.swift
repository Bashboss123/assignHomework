//
//  ViewController.swift
//  assignHomeword
//
//  Created by Sasha Fujiwara on 2021/04/14.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var dueDateTextField: UITextField!
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var assignments: [Assignment] = []
    var datePicker = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        tableView.dataSource = self
     
      if let savedAssignments = UserDefaults.standard.data(forKey: "assignments") {
            if let assignmentsDecoded = try? JSONDecoder().decode([Assignment].self, from: savedAssignments) as [Assignment] {
                assignments = assignmentsDecoded
            
            } else {
                print("Decoding failed")
            }
        }
         
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
       
        if let newAssignmentName = textField.text {
            print(newAssignmentName)
            textField.text = newAssignmentName
            
            
            ///Function called to present datePicker

            tableView.reloadData()


    }
        textField.resignFirstResponder()
   
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            assignments.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
        
    }
    
    func createDatePicker(textField: UITextField){
        datePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        datePicker.backgroundColor = UIColor.gray

        
        print("Function called")
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        textField.inputView = self.datePicker
        datePicker.datePickerMode = .dateAndTime
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        let cancleButton = UIBarButtonItem(title: "Cancle", style: .plain, target: nil, action: #selector(canclePressed))
        toolBar.setItems([doneButton], animated: true)
        textField.inputAccessoryView = toolBar
        textField.inputView = datePicker
        toolBar.isUserInteractionEnabled = true

    }
    @objc func canclePressed() {
        textField.resignFirstResponder()
    }
    
       @objc func donePressed(){
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY, MMM d, hh:mm"
        let theDate = datePicker.date
        let chosenDate = dateFormatter.string(from: theDate)
        print(chosenDate)
        self.view.endEditing(true)
            
   ///         let newAssignment =  Assignment(assignmentName: currentAssignment, dueDate: chosenDate)
           ///   assignments.append(newAssignment)
        if let encoded = try? JSONEncoder().encode(assignments) {
            UserDefaults.standard.set(encoded, forKey: "assignments")
        }
        textField.text = ""

        tableView.reloadData()
              textField.resignFirstResponder()
        
    }

    @IBAction func editButton(_ sender: UIBarButtonItem) {
        if let assignment = tableView.indexPathForSelectedRow {
            let textField = UITextField()
          }
    }
    
    func textFieldDidBeginEditing(textField:) {
        createDatePicker(textField: dueDateTextField)
    }


}
