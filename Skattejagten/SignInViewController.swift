//
//  SignInViewController.swift
//  Skattejagten
//
//  Created by Johanne Kristine Kappel Pauls on 15/06/2018.
//  Copyright © 2018 Johanne Kristine Kappel Pauls. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func signInButtonClicked(_ sender: Any) {
        guard
            let email = emailTF.text,
            let password = passwordTF.text,
            email.count > 0,
            password.count > 0
        else {
            return
        }
        
        
        
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if let error = error, user == nil {
                let alert = UIAlertController(title: "Sign In Failed",
                                              message: error.localizedDescription,
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                
                self.present(alert, animated: true, completion: nil)
            }
            else {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let homeViewController = storyboard.instantiateViewController(withIdentifier: "homeVCID")
                self.present(homeViewController, animated: true, completion: nil)
            }
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
