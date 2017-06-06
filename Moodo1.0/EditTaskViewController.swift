//
//  EditTaskViewController.swift
//  Moodo1.0
//
//  Created by Mohamed SADAT on 05/06/2017.
//  Copyright © 2017 Mohsadat. All rights reserved.
//

import UIKit
import Firebase

class EditTaskViewController: UIViewController {

    @IBOutlet weak var taskLabel: UILabel!
    var ref: DatabaseReference!
    var taskEditing = ""
    @IBOutlet weak var taskDateLabel: UILabel!
    
    @IBOutlet weak var doneSwitch: UISwitch!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    
    @IBAction func backButton(_ sender: Any) {
        
            dismiss(animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func editTaskAction(_ sender: Any) {
        
        let user = Auth.auth().currentUser
        
        ref = Database.database().reference()
        
        let taskToEditRef = ref.child("Todo").child((user?.uid)!).child(taskEditing).child("task")
        
        var done = ""
        
        if doneSwitch.isOn {
            done = "yes"
        } else {
            done = "no"
        }
        
        let childUpdates = ["done": done]
        
        taskToEditRef.updateChildValues(childUpdates)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TaskAddedViewController")
        self.present(vc!, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let user = Auth.auth().currentUser
        
        print("I'm in")
        print(taskEditing)
        
        ref = Database.database().reference()
        let taskToEditRef = ref.child("Todo").child((user?.uid)!).child(taskEditing).child("task")
        
        taskToEditRef.observe(DataEventType.value, with: { snapshot in
            
            let value = snapshot.value as? NSDictionary
            if value != nil {
                let taskToEdit = value?["taskname"] as! String
                let taskCategoryToEdit = value?["category"]
                let taskDiffToEdit = value?["difficulty"]
                let taskDateToEdit = value?["date"]
                var taskDoneToEdit = value?["done"] as! String
                self.taskLabel.text = taskToEdit
                self.difficultyLabel.text = taskDiffToEdit as! String?
                self.categoryLabel.text = taskCategoryToEdit as! String?
                self.taskDateLabel.text = taskDateToEdit as! String?
                
                if taskDoneToEdit == "no" {
                    self.doneSwitch.setOn(false, animated: true)
                } else {
                    self.doneSwitch.setOn(true, animated: true)
                }
                
            }
        })
        
        
        
        
        // Do any additional setup after loading the view.
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
