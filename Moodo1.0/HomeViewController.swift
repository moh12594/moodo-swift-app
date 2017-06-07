//
//  HomeViewController.swift
//  Moodo1.0
//
//  Created by Mohamed SADAT on 28/05/2017.
//  Copyright © 2017 Mohsadat. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    

    @IBOutlet weak var labelOut: UILabel!
    
    @IBOutlet weak var tasksTable: UITableView!
    

    @IBOutlet weak var editButton: UIButton!
    
    var taskSources = [String]()
    var difficultySources = [String]()
    var categorySources = [String]()
    var taskKeys = [String]()
    var taskKeysEdit = [String]()

    
    var moodPassed = ""
    var ref: DatabaseReference!
    

    


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let backColor = UIColor(red: 250/255.0, green: 251/255.0, blue: 252/255.0, alpha: 1.0)
        view.backgroundColor = backColor
        self.tasksTable.backgroundColor = backColor
        tasksTable.dataSource = self
        
        
        ref = Database.database().reference()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let date = dateFormatter.string(from: Date())
        let dateDate = dateFormatter.date(from: date)
       // print(dateDate)
        
        let user = Auth.auth().currentUser
        
        
        
        let moodOfDayRef = ref.child("moods").child((user?.uid)!).child(date)
        
        moodOfDayRef.observe(DataEventType.value, with: { snapshot in
            
            let value = snapshot.value as? NSDictionary
            if value != nil {
                let moodOfday = value?["moodName"] as! String
                let moodEmoji = Utilities().moodPassedToEmoji(moodText: moodOfday)
                self.labelOut.text = moodEmoji
                // print(moodOfday)
            }
        })
        
        
        
        
        
        let tasksRef = ref.child("Todo").child((user?.uid)!)
        
        tasksRef.observe(DataEventType.value, with: { snapshot in
            
            
            //print(snapshot.children)
            
            
            if let result = snapshot.children.allObjects as? [DataSnapshot] {
                for child in result {
                    let userKey = child.key
                    self.taskKeys.append(userKey as! String)
                   // print(userKey)
                }
            }
           // print(self.taskKeys)
            
            for taskKey in self.taskKeys {
                let tasksReference = self.ref.child("Todo").child((user?.uid)!).child(taskKey).child("task")
                self.taskSources.removeAll()
                self.difficultySources.removeAll()
                self.categorySources.removeAll()
                tasksReference.observe(DataEventType.value, with: { snapshot in
                    
                    let value = snapshot.value as? NSDictionary
                    if value != nil {
                        let taskOfday = value?["taskname"] as! String
                        let categoryOfday = value?["category"] as! String
                        let difficultyOfday = value?["difficulty"] as! String
                        let doneTask = value?["done"] as! String
                        let dateOftask = value?["date"] as! String
                        let dateOfTask = dateFormatter.date(from: dateOftask)
                        
                        
                        
                        
                        if (dateDate?.compare(dateOfTask!) == ComparisonResult.orderedAscending || dateDate?.compare(dateOfTask!) == ComparisonResult.orderedSame) {
                            if (doneTask == "no") {
                                
                                Utilities().displayTasksAccordingToMood(task: taskOfday, difficulty: difficultyOfday, category: categoryOfday, taskTable: &self.taskSources, difficultyTable: &self.difficultySources, categoryTable: &self.categorySources, displayTable: self.tasksTable, mood: self.labelOut.text!, keysTable: &self.taskKeysEdit, key: taskKey)
                            
                            }
                            

                        }
                        //                        print(taskOfday)
                        //                        print(categoryOfday)
                        //                        print(difficultyOfday)
                    }
                    // print(self.taskSources)
                    
                })
                
            }
            
            
        })
        
        
        
        
        /**
        ref = Database.database().reference()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        let date = dateFormatter.string(from: Date())
        let moodTest = moodPassedTest(moodNumber: moodPassed)
        
        
        
        print("\(date) and \(moodTest)")
        let mood = Mood()
        mood.moodName = moodTest
        mood.date = date
        
        
        
        print("\(mood.moodName!)")
        let user = Auth.auth().currentUser
        
        //let key = ref.child("moods").childByAutoId().key
        
        let dictionaryMood:NSDictionary = ["moodName": "\(mood.moodName!)", "date": "\(mood.date!)"]
        
        //let childUpdates = ["/moods/\(key)": dictionaryMood]
        
        self.ref?.child("moods").child((user?.uid)!).child(date).setValue(dictionaryMood)
            
        **/
        
    }
    

    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        



        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
        
        
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let editVC = segue.destination as! EditTaskViewController
        
        if segue.identifier == "editTask" {

            let indexPath = tasksTable.indexPathForSelectedRow
            let taskSelected = taskKeysEdit[(indexPath?.row)!]
          //  print(taskKeysEdit)
            editVC.taskEditing = taskSelected
        
        }
        
    }


}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return taskSources.count
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! taskCell
        //cell.layer.borderWidth = 1
        //cell.layer.cornerRadius = 30
        
        
        cell.configureCell(task: taskSources[indexPath.row], difficulty: difficultySources[indexPath.row], category: categorySources[indexPath.row])

        
        return cell
    }
}
