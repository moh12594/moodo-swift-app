//
//  LoginViewController.swift
//  Moodo1.0
//
//  Created by Mohamed SADAT on 21/05/2017.
//  Copyright © 2017 Mohsadat. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginClicked(_ sender: Any) {
        
        let email = emailTextField.text
        let password = passwordTextField.text
        
        Auth.auth().signIn(withEmail: email!, password: password!, completion: { (user, error) in
            if let error = error {
                Utilities().showAlert(title: "Erreur !", message: error.localizedDescription, vc: self)
                // print(error.localizedDescription)
                return
            } else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "moodTableViewController")
                self.present(vc!, animated: true)
            }

            
        })
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if(Auth.auth().currentUser != nil) {
            
            // print("already logged")
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "moodTableViewController")
            self.present(vc!, animated: false)
            
        } else if (Auth.auth().currentUser == nil) {
            
            // print("not logged yet")
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
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
