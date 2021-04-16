//
//  ViewController.swift
//  assignHomeword
//
//  Created by Sasha Fujiwara on 2021/04/14.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var assignments: [assignment] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        if let newAssignmentName = textField.text {
            let newAssignment =
        }
    }
    
}

