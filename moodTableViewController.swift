//
//  moodTableViewController.swift
//  Moodo1.0
//
//  Created by Mohamed SADAT on 01/06/2017.
//  Copyright © 2017 Mohsadat. All rights reserved.
//

import UIKit
import Firebase

class moodTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var ref: DatabaseReference!
    
    let moodSources = ["😄", "😊", "😤", "😞", "😐", "😶"];
    let moodTextSources = ["Excited", "Happy", "Angry", "Sad", "Jaded", "Neutral"];
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            if segue.identifier == "moodChoosed" {
                
                if let HomeViewController = segue.destination as? HomeViewController, let ip = tableView.indexPathForSelectedRow {
                    
                    HomeViewController.moodPassed = self.moodTextSources[ip.row]
                    
                }
                
                
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Hello")
        
        // Do any additional setup after loading the view.
        
        ref = Database.database().reference()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let date = dateFormatter.string(from: Date())
        let user = Auth.auth().currentUser
        
        
        
        let moodOfDayRef = ref.child("moods").child((user?.uid)!).child(date)
        
        moodOfDayRef.observe(DataEventType.value, with: { snapshot in
            
            let value = snapshot.value as? NSDictionary
            if value != nil {
                
                let moodOfday = value?["moodName"] as! String
                
                if moodOfday != nil {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController")
                self.present(vc!, animated: false)
                }
            }
        })
        
    }
    
    
    
    

    override func viewWillDisappear(_ animated: Bool) {
        let ip = tableView.indexPathForSelectedRow
        // print(moodTextSources[(ip?.row)!])
        
        
        if(ip != nil) {
            ref = Database.database().reference()
        
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
        
            let date = dateFormatter.string(from: Date())
            let moodTest = moodTextSources[(ip?.row)!]
        
        
        
            // print("\(date) and \(moodTest)")
            let mood = Mood()
            mood.moodName = moodTest
            mood.date = date
        
        
        
            // print("\(mood.moodName!)")
            let user = Auth.auth().currentUser
        
            //let key = ref.child("moods").childByAutoId().key
        
            let dictionaryMood:NSDictionary = ["moodName": "\(mood.moodName!)", "date": "\(mood.date!)"]
        
            //let childUpdates = ["/moods/\(key)": dictionaryMood]
        
            self.ref?.child("moods").child((user?.uid)!).child(date).setValue(dictionaryMood)
        }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.setHidesBackButton(true, animated: animated)
        
        if(Auth.auth().currentUser == nil) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "firebaseLoginViewController")
            self.show(vc!, sender: self)
        }
        
        
        
        
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

extension moodTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moodSources.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! moodCell
        //cell.layer.borderWidth = 1
        //cell.layer.cornerRadius = 30

        
        cell.configureCell(mood: moodSources[indexPath.row], moodText: moodTextSources[indexPath.row])
        
        
        return cell
    }
    
    
}

