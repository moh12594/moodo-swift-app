//
//  profilViewController.swift
//  Moodo1.0
//
//  Created by Mohamed SADAT on 04/06/2017.
//  Copyright © 2017 Mohsadat. All rights reserved.
//

import UIKit
import Firebase

class profilViewController: UIViewController {

    
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    
    @IBOutlet weak var moodLabel: UILabel!
    var ref: DatabaseReference!
    
    
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameSecondLabel: UILabel!
    

    
    @IBAction func logoutAction(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "firebaseLoginViewController")
            self.present(vc!, animated: false)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let backColor = UIColor(red: 250/255.0, green: 251/255.0, blue: 252/255.0, alpha: 1.0)
        view.backgroundColor = backColor
        
        let storage = Storage.storage()
        
        let storageRef = storage.reference()
        
        let imagesRef = storageRef.child("users/fian@2x.png")
        // Download the data, assuming a max size of 1MB (you can change this as necessary)
        imagesRef.getData(maxSize: 1 * 1024 * 1024) { (data, error) -> Void in
            // Create a UIImage, add it to the array
            let pic = UIImage(data: data!)
            self.avatarImage.image = pic
            self.avatarImage.layer.masksToBounds = false
            self.avatarImage.layer.cornerRadius = self.avatarImage.frame.size.height / 2;
            self.avatarImage.clipsToBounds = true
        }
        

        
//        nameView.layer.borderWidth = 1
        nameView.layer.borderColor = backColor.cgColor
        
        ref = Database.database().reference()
        
        
        let user = Auth.auth().currentUser
        let uid = user?.uid
        let email = user?.email
        
        emailLabel.text = email
        
        
        let nameRef = ref.child("users").child(uid!)
        
        nameRef.observe(DataEventType.value, with: { snapshot in
            
            let value = snapshot.value as? NSDictionary
            if value != nil {
                let userName = value?["userName"] as! String
                self.nameLabel.text = userName
                self.nameSecondLabel.text = userName
            }
        })
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let date = dateFormatter.string(from: Date())

        
        let moodOfDayRef = ref.child("moods").child((user?.uid)!).child(date)
        
        
        
        moodOfDayRef.observe(DataEventType.value, with: { snapshot in
            
            let value = snapshot.value as? NSDictionary
            if value != nil {
                let moodOfday = value?["moodName"] as! String
                let moodEmoji = Utilities().moodPassedToEmoji(moodText: moodOfday)
                self.moodLabel.text = moodEmoji + " Mood of the day"

                // print(moodOfday)
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
