//
//  ViewController.swift
//  Moodo1.0
//
//  Created by Mohamed SADAT on 19/05/2017.
//  Copyright © 2017 Mohsadat. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITableViewDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Déconnexion de l'utilisateur
        
        let auth = Auth.auth()
        /**do {
            try auth.signOut()
            
        } catch let signOutError as NSError {
            // print("Error siging out")
        }**/
        
        if(auth.currentUser == nil) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "firebaseLoginViewController")
            self.navigationController?.present(vc!, animated: true, completion: nil)
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController")
            self.navigationController?.present(vc!, animated: true, completion: nil)
        }
        
       /** Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "moodViewController")
                self.navigationController?.present(vc!, animated: true, completion: nil)
            } else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "firebaseLoginViewController")
                self.navigationController?.present(vc!, animated: true, completion: nil)
            }
        }**/
        
    }
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
       
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

