//
//  ViewController.swift
//  assignHomeword
//
//  Created by Sasha Fujiwara on 2021/04/14.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UITableViewDataSource {
    var newUser = true
    @IBOutlet weak var dueDateTextField: UITextField!
    var dueDates: [Date] = []
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var assignments: [Assignment] = []
    var datePicker = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        permissionNotification()
        

        tableView.dataSource = self
  /*
      if let savedAssignments = UserDefaults.standard.data(forKey: "assignments") {
            if let assignmentsDecoded = try? JSONDecoder().decode([Assignment].self, from: savedAssignments) as [Assignment] {
                assignments = assignmentsDecoded
            
            }
      }
        
    */
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
       newUser = false
        if let newAssignmentName = textField.text {
            print(newAssignmentName)
            textField.text = newAssignmentName
            
            if let newAssignmentDueDate = dueDateTextField.text {
                let newAssignment = Assignment(assignmentName: newAssignmentName, dueDate: newAssignmentDueDate)
                assignments.append(newAssignment)
                
                tableView.reloadData()
                storeData()
                textField.text = ""
                dueDateTextField.text = ""
                dueDates.append(datePicker.date)
                let dueDate = datePicker.date
                checkForTimeTilAssignmentDue(assignmentDueDate: dueDate, assignmentName: newAssignmentName)
                
            } else {
            let newAssignment = Assignment(assignmentName: newAssignmentName, dueDate: "")
                assignments.append(newAssignment)
            }
            ///Function called to present datePicker
}
        textField.resignFirstResponder()
   
    }
    ////////////////
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            assignments.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
        
    }
    ////////////////
    func createDatePicker(){
        datePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 100))
        datePicker.backgroundColor = UIColor.white

        datePicker.centerXAnchor
        print("Function called")
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 100))
 
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        textField.inputView = self.datePicker
        datePicker.datePickerMode = .dateAndTime
        

        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)

        
        
        let cancleButton = UIBarButtonItem(title: "Cancle", style: .plain, target: nil, action: #selector(canclePressed))
        
        
        toolBar.setItems([cancleButton], animated: true)
  

        textField.inputAccessoryView = toolBar
        textField.inputView = datePicker
        toolBar.isUserInteractionEnabled = true

    }
    ////////////////
    @objc func dateChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, hh:mm a, YYYY"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        let theDate = datePicker.date
        let chosenDate = dateFormatter.string(from: theDate)
        dueDateTextField.text = chosenDate
        dueDateTextField.adjustsFontSizeToFitWidth = true
    }
    ////////////////
    @objc func canclePressed() {
        textField.resignFirstResponder()
        view.endEditing(true)
        
    }
       

    
    
    //////////////// TextFieldGesture
    

    @IBAction func textFieldTap(_ sender: UITapGestureRecognizer) {
    
    print("TextField Tapped")
        createDatePicker()
    
    }
    ////////////////
    @IBAction func closeTextField(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
        view.endEditing(true)
    }
    
  
    func storeData() {
        if let encoded = try? JSONEncoder().encode(assignments)
        {
            UserDefaults.standard.set(encoded, forKey: "assignments")

        tableView.reloadData()
        
        } else {
            print("Encoding Failed")
            alert(message: "Encoding Failed")
        }
}
    /////////
    func alert(message: String) -> Int {
        let alert = UIAlertController(title: "Oh no we ran into a problem ", message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            
        }
        alert.addAction(okayAction)
        present(alert, animated: true, completion: nil)
        return 0
    }
    
    @IBAction func erase(_ sender: UIBarButtonItem) {
    
    UserDefaults.standard.removeObject(forKey: "assignments")
        UserDefaults.standard.removeObject(forKey: "newUser")
        assignments = []
        tableView.reloadData()
        print("Deleted all presisting data.")
        newUser = true
        UserDefaults.standard.setValue(newUser, forKey: "newUser")
    }
    func notification(notiTitle: String, notiText: String) -> UNNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = notiTitle
        content.body = notiText
        return content
    }
    func triggerNotification(dueDate: Date) -> (UNCalendarNotificationTrigger, UNCalendarNotificationTrigger, UNCalendarNotificationTrigger) {
        let fifteenMinBefore = dueDate.addingTimeInterval(-900)
        let tenMinBefore = dueDate.addingTimeInterval(-600)
        let fiveMinBefore = dueDate.addingTimeInterval(-300)
        
        let fifteenMinDateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: fifteenMinBefore)
        let tenMinDateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: tenMinBefore)
        let fiveMinDateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: fiveMinBefore)
       let fiftenTrigger = UNCalendarNotificationTrigger(dateMatching: fifteenMinDateComponents, repeats: false)
        let tenTigger = UNCalendarNotificationTrigger(dateMatching: tenMinDateComponents, repeats: false)
        let fiveTrigger = UNCalendarNotificationTrigger(dateMatching: fiveMinDateComponents, repeats: false)
        return (fiftenTrigger, tenTigger, fiveTrigger)
        
    }
    func requestNotification(content: UNNotificationContent, trigger: UNNotificationTrigger) -> UNNotificationRequest{
       
        let uuidString = UUID().uuidString
        let request =  UNNotificationRequest(identifier: uuidString , content: content, trigger: trigger)
        return request
    }
    func checkForTimeTilAssignmentDue(assignmentDueDate: Date, assignmentName: String) {
        let center = UNUserNotificationCenter.current()
        center.removeAllDeliveredNotifications()
        center.removeAllPendingNotificationRequests()
        let assignmentDue = assignmentDueDate
        
            let date = Date()
            let calendar = Calendar.current
            let dueDateTime = triggerNotification(dueDate: assignmentDue)
            let dueDateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: assignmentDue)
       
          
           let notificationTriggers = triggerNotification(dueDate: assignmentDue)
            let fifteenMinBefore = notificationTriggers.0
            let tenMinBefore = notificationTriggers.1
            let fiveMinBefore = notificationTriggers.2
            if let assignmentDueIndex = dueDates.firstIndex(of: assignmentDue) {
                
            let fifteenMinContent = notification(notiTitle: "\(assignmentName)", notiText: "Due in 15 minutes.")
            let tenMinContent = notification(notiTitle: "\(assignmentName)", notiText: "Due in 10 minutes.")
                let fiveMinContent = notification(notiTitle: "\(assignmentName)", notiText: "Due in 5 minutes.")
                let fifteenMinBeforeRequest = requestNotification(content: fifteenMinContent, trigger: fifteenMinBefore)
                let tenMinBeforeRequest = requestNotification(content: tenMinContent, trigger: tenMinBefore)
                let fiveMinRequest = requestNotification(content: fiveMinContent, trigger: fiveMinBefore)
                
                center.add(fifteenMinBeforeRequest) { error in
                    print("Failed request")
                    center.add(tenMinBeforeRequest) { error in
                        print("Failed request")
                    }
                    center.add(fiveMinRequest) { error in
                        print("Failed request")
                    }
                }
                

            
            } else {
                print("Cannot find corresponding assignment.")
            }
    

}
    func permissionNotification() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            self.alert(message: "You won't receive notifications for upcoming assignments. You can change this in settings.")
        }

    }
}
