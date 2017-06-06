//
//  RegisterViewController.swift
//  Moodo1.0
//
//  Created by Mohamed SADAT on 22/05/2017.
//  Copyright © 2017 Mohsadat. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var ref: DatabaseReference!

    
    @IBAction func signInShow(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func signUpClicked(_ sender: Any) {
        
        ref = Database.database().reference()
        

        
        
        let email = emailTextField.text
        let password = passwordTextField.text
        let name = nameTextField.text
        
        
        
        Auth.auth().createUser(withEmail: email!, password: password!) { (user, error) in
            if let error = error {
                Utilities().showAlert(title: "Erreur !", message: error.localizedDescription, vc: self)
                print(error.localizedDescription)
                return
            }
            
            
            
            Auth.auth().currentUser?.sendEmailVerification { (error) in
                
            let refName = self.ref.child("users").child((Auth.auth().currentUser!.uid)).child("userName")
                
                refName.setValue(name)
                
                Utilities().showAlert(title: "Great !", message: "Veuillez valider votre e-mail !", vc: self)
                
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
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
