//
//  StatsViewController.swift
//  Moodo1.0
//
//  Created by Mohamed SADAT on 06/06/2017.
//  Copyright © 2017 Mohsadat. All rights reserved.
//

import UIKit
import Firebase


class StatsViewController: UIViewController {

    
    var ref: DatabaseReference!
    var dateTables = [String]()
    var moodsTable = [String]()
    var happyTable = [String]()
    var taskKeys = [String]()
    var tasksDone = [String]()
    
    @IBOutlet weak var happyView: UIView!
    @IBOutlet weak var tasksView: UIView!
    @IBOutlet weak var moodsLabel: UILabel!
    @IBOutlet weak var happyLabel: UILabel!
    
    @IBOutlet weak var tasksLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        happyView.layer.shadowColor = UIColor.black.cgColor
        happyView.layer.shadowOpacity = 0.3
        happyView.layer.shadowOffset = CGSize.zero
        happyView.layer.shadowRadius = 1
        
        tasksView.layer.shadowColor = UIColor.black.cgColor
        tasksView.layer.shadowOpacity = 0.3
        tasksView.layer.shadowOffset = CGSize.zero
        tasksView.layer.shadowRadius = 1

        
        
        getHappyMoods()
        getTasksDone()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func getTasksDone() {
        
        ref = Database.database().reference()
        let user = Auth.auth().currentUser
        
        let tasksRef = ref.child("Todo").child((user?.uid)!)
        
        tasksRef.observe(DataEventType.value, with: { snapshot in
            
            
            //print(snapshot.children)
            
            
            if let result = snapshot.children.allObjects as? [DataSnapshot] {
                for child in result {
                    let userKey = child.key
                    self.taskKeys.append(userKey as! String)
//                    print(userKey)
                }
            }
//            print(self.taskKeys)
            
            for taskKey in self.taskKeys {
                let tasksReference = self.ref.child("Todo").child((user?.uid)!).child(taskKey).child("task")
                
                tasksReference.observe(DataEventType.value, with: { snapshot in
                    
                    let value = snapshot.value as? NSDictionary
                    if value != nil {
                        let taskDone = value?["done"] as! String
                        let taskName = value?["taskname"] as! String
                        if taskDone == "yes" {
                            
                            
                            self.tasksDone.append(taskName)
                            
                            
                            
                        }
//                        print(self.tasksDone.count)
                        self.tasksLabel.text = String(self.tasksDone.count)
                    }

                    
                })
                
            }
            
            
        })

    }
    
    
    
    func getHappyMoods()  {
        ref = Database.database().reference()
        let user = Auth.auth().currentUser
        
        
        
        let datesRef = ref.child("moods").child((user?.uid)!)
        
        datesRef.observe(DataEventType.value, with: { snapshot in
//            print(snapshot)
            
            if let result = snapshot.children.allObjects as? [DataSnapshot] {
                for child in result {
                    let date = child.key
                    self.dateTables.append(date as! String)
//                    print(date)
                }
            }
//            print(self.dateTables)
            
            for date in self.dateTables {
             
                let moodRef = self.ref.child("moods").child((user?.uid)!).child(date)
                
                moodRef.observe(DataEventType.value, with: { snapshot in
                    
                    let value = snapshot.value as? NSDictionary
                    if value != nil {
                        let moodOfDate = value?["moodName"] as! String
                        self.moodsTable.append(moodOfDate)
                        
                        if (moodOfDate == "Happy" || moodOfDate == "Excited") {
                            self.happyTable.append(moodOfDate)
                        }
                    }
//                    print(self.moodsTable)
//                    print(self.happyTable)
                    self.moodsLabel.text = String(self.moodsTable.count)
                    self.happyLabel.text = String(self.happyTable.count)
                })
                
            }
            
            
        })
        
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
