//
//  ViewController.swift
//  JEMCA
//
//  Created by Johanne Kristine Kappel Pauls on 18/04/2018.
//  Copyright © 2018 Johanne Kristine Kappel Pauls. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var datePickerTF: UITextField!
    let datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
    }
    
    func createDatePicker(){
        
        //format for datepicker display
        datePicker.datePickerMode = .date
        
        //assign datepicker to our textfield
        datePickerTF.inputView = datePicker
        
        //create a toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //add a done button on this toolbar
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
        
        toolbar.setItems([doneButton], animated: true)
        
        datePickerTF.inputAccessoryView = toolbar
    }
    
    @objc func doneClicked(){
        
        //format for displaying the date in our textfield
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        datePickerTF.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
