//
//  ViewController.swift
//  JEMCA
//
//  Created by Johanne Kristine Kappel Pauls on 18/04/2018.
//  Copyright © 2018 Johanne Kristine Kappel Pauls. All rights reserved.
//

import UIKit
import Firebase

class signUpViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //outlets
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var repeatPasswordTF: UITextField!
    @IBOutlet weak var sexSC: UISegmentedControl!
    @IBOutlet weak var favoriteColorTF: UITextField!
    @IBOutlet weak var hairColorTF: UITextField!
    @IBOutlet weak var birthdayTF: UITextField!
    
    //attributs
    let datePicker = UIDatePicker()
    var email: String = ""
    var password: String = ""
    var repeatPassword: String = ""
    var sex: String = ""
    var favoriteColor: String = ""
    var favoriteColorOption = ["Blå", "Gul", "Rød", "Grøn", "Lilla"]
    var haircolor: String = ""
    var hairColorOption = ["blond", "brun", "sort", "hvidt"]
    var birthday: String = ""
    var isPassword: Bool?
    let pickerView = UIPickerView()
    let favoriteColorPickerView = UIPickerView()
    let hairColorPickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTF.delegate = self
        self.passwordTF.delegate = self
        self.repeatPasswordTF.delegate = self
        
        self.favoriteColorPickerView.delegate = self
        
        favoriteColorPickerView.tag = 1
        
        favoriteColorTF.inputView = favoriteColorPickerView
        
        
        self.hairColorPickerView.delegate = self
        
        hairColorPickerView.tag = 2
        
        hairColorTF.inputView = hairColorPickerView

        createDatePicker()
    }
    @IBAction func signUpClicked(_ sender: UIButton) {
        getSignUpInfo()
        
        checkPassword()
        if isPassword == true {
            //gem i databasen
            Auth.auth().createUser(withEmail: email, password: password) { user, error in
                if error == nil {
                    Auth.auth().signIn(withEmail: self.email, password: self.password)
                    //tilføj noget til en bruger database
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let homeViewController = storyboard.instantiateViewController(withIdentifier: "homeVCID")
                    self.present(homeViewController, animated: true, completion: nil)
                    
                    let alert = UIAlertController(title: "🗺VELKOMMEN TIL SKATTEJAGTEN🗺",
                                                  message: "Sådan! du er en del af skattejagten",
                                                  preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "NICE!", style: .default))
                    
                    self.present(alert, animated: true, completion: nil)
                }
                else if let error = error{
                    let alert = UIAlertController(title: "Sign Up Failed",
                                                  message: error.localizedDescription,
                                                  preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.emailTF.resignFirstResponder()
        self.passwordTF.resignFirstResponder()
        self.repeatPasswordTF.resignFirstResponder()
        return true
    }
    
    func getSignUpInfo(){
        email = emailTF.text!
        password = passwordTF.text!
        repeatPassword = repeatPasswordTF.text!
        sex = sexSC.titleForSegment(at: sexSC.selectedSegmentIndex)!
        favoriteColor = favoriteColorTF.text!
        haircolor = hairColorTF.text!
        birthday = birthdayTF.text!
    }
    
    func checkPassword() {
        if password == repeatPassword {
            isPassword = true
        } else {
            let passwordAlertController = UIAlertController(title: "⛔️ Kodeord ikke ens ⛔️", message: "Kodeordene stemmer ikke overens. Ændre kodeord og prøv igen", preferredStyle: .alert)
            let passwordAlertAction = UIAlertAction(title: "❌ Luk", style: .cancel, handler: nil)
            passwordAlertController.addAction(passwordAlertAction)
            present(passwordAlertController, animated: true, completion: nil)
            isPassword = false
        }
    }

    func createDatePicker(){
        
        //format for datepicker display
        datePicker.datePickerMode = .date
        datePicker.locale = NSLocale(localeIdentifier: "da_DA") as Locale
        
        //assign datepicker to our textfield
        birthdayTF.inputView = datePicker
        
        //create a toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //add a done button on this toolbar
        let doneButton = UIBarButtonItem(title: "Færdig", style: .plain, target: nil, action: #selector(doneClicked))
        
        toolbar.setItems([doneButton], animated: true)
        
        birthdayTF.inputAccessoryView = toolbar
    }
    
    @objc func doneClicked(){
        //format for displaying the date in our textfield
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.locale = NSLocale(localeIdentifier: "da_DA") as Locale
        birthdayTF.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            
            return favoriteColorOption.count
            
        }
        
        if pickerView.tag == 2 {
            
            return hairColorOption.count
            
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
        
        return favoriteColorOption[row]
        }
        
        if pickerView.tag == 2 {
        
        return hairColorOption[row]
        
        }
        
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            
            favoriteColorTF.text = favoriteColorOption[row]
            
        }
        
        if pickerView.tag == 2 {
            
            hairColorTF.text = hairColorOption[row]
            
        }
    }
}
