//
//  AddTaskViewController.swift
//  Moodo1.0
//
//  Created by Mohamed SADAT on 03/06/2017.
//  Copyright © 2017 Mohsadat. All rights reserved.
//

import UIKit
import Firebase


class AddTaskViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var ref: DatabaseReference!
    var pickerDataSource = [String]()
    var diffPickerDataSource = [String]()
    
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var datePickertextView: UITextField!
    @IBOutlet weak var pickerTextField: UITextField!

    @IBOutlet weak var diffPickerTextField: UITextField!
    
    
    var dateTodo:Date?
    
    let categoryPickerView = UIPickerView()
    let difficultyPickerView = UIPickerView()
    var datePickerView:UIDatePicker?
    
    
    
    
    
    
    
    @IBAction func addTaskAction(_ sender: UIButton) {
        
        if ( !((datePickertextView?.text)!.isEmpty) && !((pickerTextField.text)!.isEmpty) && !((diffPickerTextField.text)!.isEmpty) && !((taskNameTextField.text)!.isEmpty) ) {
            

             ref = Database.database().reference()
            
            let category = pickerTextField.text
            let  difficulty = diffPickerTextField.text
            let date = datePickertextView.text
            let taskName = taskNameTextField.text
            
            
            
            let user = Auth.auth().currentUser
            
            
            let dictionaryTask:NSDictionary = ["category": "\(category!)", "date": "\(date!)", "difficulty": "\(difficulty!)", "done": "no", "taskname": "\(taskName!)"]
            
            
            self.ref?.child("Todo").child((user?.uid)!).childByAutoId().child("task").setValue(dictionaryTask)
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TaskAddedViewController")
            self.present(vc!, animated: true)
            
            
        } else {
           Utilities().showAlert(title: "Erreur !", message: "Tous les champs sont obligatoires :( ", vc: self)
        }
        
        
        
    }
    
    
    
    
    
    
    
    // MARK: - Date Picker View
    
    func addDatePickerView() {
        datePickerView = UIDatePicker()
        datePickerView?.datePickerMode = UIDatePickerMode.date
        datePickerView?.addTarget(self, action: #selector(AddTaskViewController.selectionDate(_:)), for: .valueChanged)
        
        
        datePickertextView.inputView = datePickerView
    }
    
    func selectionDate(_ sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        datePickertextView.text = dateFormatter.string(from: sender.date)
        dateTodo = sender.date
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backColor = UIColor(red: 250/255.0, green: 251/255.0, blue: 252/255.0, alpha: 1.0)
        view.backgroundColor = backColor
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddTaskViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
        ref = Database.database().reference()
        
        
        let categoryRef = ref.child("categories")
        
        categoryRef.observe(DataEventType.value, with: { snapshot in
            
            let value = snapshot.value as? NSDictionary
            if value != nil {
                
                for (key, valeur) in value! {
                    // print(valeur)
                    self.pickerDataSource.append(valeur as! String)
                }
                
                // self.pickerDataSource = value?.allKeys as! [String]
                // print(self.pickerDataSource)
                
                
            }
        })
        
        let difficultyRef = ref.child("difficulties")
        
        difficultyRef.observe(DataEventType.value, with: { snapshot in
            
            let value = snapshot.value as? NSDictionary
            if value != nil {
                
                for (key, valeur) in value! {
                    // print(valeur)
                    self.diffPickerDataSource.append(valeur as! String)
                }
                
                // self.pickerDataSource = value?.allKeys as! [String]
                // print(self.diffPickerDataSource)
                
                
            }
        })

        
        addDatePickerView()
        
        categoryPickerView.delegate = self
        difficultyPickerView.delegate = self
        pickerTextField.inputView = categoryPickerView
        diffPickerTextField.inputView = difficultyPickerView
        
        
        // Do any additional setup after loading the view.
        

        
    }
    
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var number = 1
        
        if pickerView == categoryPickerView {
            number = pickerDataSource.count
        } else {
            number = diffPickerDataSource.count
        }
        return number
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var selected = ""
        if pickerView == categoryPickerView {
            
            selected = pickerDataSource[row]
            
        } else {
            
            selected = diffPickerDataSource[row]
        }
        
        return selected
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == categoryPickerView {
            pickerTextField.text = pickerDataSource[row]
        } else {
            diffPickerTextField.text = diffPickerDataSource[row]
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func formatDate(_ date:Date) -> String {
        
        var dateStr:String?
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateStr = dateFormatter.string(from: date)
        
        return dateStr!
    }
    
    
    func dateFromStr(_ dateStr: String) -> Date {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let date = formatter.date(from: dateStr)
        
        return date!
    }

}
