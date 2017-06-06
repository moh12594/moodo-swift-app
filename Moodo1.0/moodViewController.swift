//
//  moodViewController.swift
//  Moodo1.0
//
//  Created by Mohamed SADAT on 22/05/2017.
//  Copyright © 2017 Mohsadat. All rights reserved.
//

import UIKit
import Firebase

class moodViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var moodButtonChoice: UIButton!
    var ref: DatabaseReference!
    
    
    @IBOutlet weak var pickerViewOut: UIPickerView!

    @IBAction func moodValidate(_ sender: UIButton) {
        
        // print(pickerViewOut.selectedRow(inComponent: 0))
        
       /** let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        vc.moodPassed = pickerViewOut.selectedRow(inComponent: 0)
        navigationController?.show(vc, sender: self)
        **/
    }
    
    
     override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        if(Auth.auth().currentUser == nil) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "firebaseLoginViewController")
            self.navigationController?.show(vc!, sender: self)
        }

        
    }
    
    let pickerDataSource = ["😄 Excited", "😊 Happy", "😤 Angry", "😞 Sad", "😐 Jaded", "😶 Neutral"];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        pickerViewOut.dataSource = self
        pickerViewOut.delegate = self
        
        
        
        //let red = UIColor(red: 100.0/255.0, green: 130.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        
        //pickerViewOut.layer.borderColor = red.cgColor
        
        //pickerViewOut.layer.borderWidth = 4
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
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
