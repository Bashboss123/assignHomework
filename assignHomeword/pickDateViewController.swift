//
//  pickDateViewController.swift
//  assignHomeword
//
//  Created by Sasha Fujiwara on 2021/04/14.
//

import UIKit

class pickDateViewController: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    @IBAction func done(_ sender: UIButton) {
        if let date = datePicker.date as! String {
            UserDefaults.setValue(date, forKey: "date")
        }
    }
    

    

}
