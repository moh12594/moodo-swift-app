//
//  moodCell.swift
//  Moodo1.0
//
//  Created by Mohamed SADAT on 01/06/2017.
//  Copyright © 2017 Mohsadat. All rights reserved.
//

import UIKit

class taskCell: UITableViewCell {
    

    @IBOutlet weak var taskCellView: UIView!
//    @IBOutlet weak var taskCellTimeView: UIView!
    
    @IBOutlet weak var taskNameLabel: UILabel!
//    @IBOutlet weak var taskNameTimeLabel: UILabel!
    @IBOutlet weak var taskCatLabel: UILabel!
//    @IBOutlet weak var taskCatTimeLabel: UILabel!
    @IBOutlet weak var taskDiffLabel: UILabel!
//    @IBOutlet weak var taskDiffTimeLabel: UILabel!
    @IBOutlet weak var iconLabel: UILabel!
//    @IBOutlet weak var iconTimeLabel: UILabel!
    
    func configureCell(task: String, difficulty: String, category: String) {
        
        
        taskNameLabel.text = task
        taskDiffLabel.text = difficulty
        
        var diffColor = UIColor()
        
        
        if (difficulty == "Hard") {
            diffColor = UIColor(red: 230/255.0, green: 99/255.0, blue: 99/255.0, alpha: 1.0)
        }
        if (difficulty == "Easy") {
            diffColor = UIColor(red: 151/255.0, green: 231/255.0, blue: 99/255.0, alpha: 1.0)
        }
        if (difficulty == "Medium") {
            diffColor = UIColor(red: 230/255.0, green: 162/255.0, blue: 99/255.0, alpha: 1.0)
        }
        
        taskDiffLabel.layer.backgroundColor = diffColor.cgColor
        
        taskDiffLabel.layer.cornerRadius = 10
        
        
        let attachment = NSTextAttachment()
        
        if category == "homework" {
            attachment.image = UIImage(named: "homeCat")
        }
        else if category == "travel" {
            attachment.image = UIImage(named: "travelCat")
        }
        else if category == "personal" {
            attachment.image = UIImage(named: "persoCat")
        }
        else {
            attachment.image = UIImage(named: "homeCat")
        }
        
        
        let attachmentString = NSAttributedString(attachment: attachment)
        let iconText = NSMutableAttributedString(string: "")
        iconText.append(attachmentString)
        iconLabel.attributedText = iconText
        
        
        
        taskCatLabel.text = category
        
        
        taskCellView.layer.shadowColor = UIColor.black.cgColor
        taskCellView.layer.shadowOpacity = 0.3
        taskCellView.layer.shadowOffset = CGSize.zero
        taskCellView.layer.shadowRadius = 1

        
//        taskCellView.layer.borderWidth = 1
//        taskCellView.layer.borderColor = UIColor.lightGray.cgColor
        
        taskCellView.layer.cornerRadius = 7
        
    }
    
//    
//    func configureTimeCell(task: String, difficulty: String, category: String) {
//        
//        
//        taskNameTimeLabel.text = task
//        taskDiffTimeLabel.text = difficulty
//        
//        if (difficulty == "Hard") {
//            taskDiffTimeLabel.layer.backgroundColor = UIColor.red.cgColor
//        }
//        if (difficulty == "Easy") {
//            taskDiffTimeLabel.layer.backgroundColor = UIColor.green.cgColor
//        }
//        if (difficulty == "Medium") {
//            taskDiffTimeLabel.layer.backgroundColor = UIColor.orange.cgColor
//        }
//        taskDiffTimeLabel.layer.cornerRadius = 10
//        
//        
//        let attachment = NSTextAttachment()
//        
//        if category == "homework" {
//            attachment.image = UIImage(named: "homeCat")
//        }
//        else if category == "travel" {
//            attachment.image = UIImage(named: "travelCat")
//        }
//        else if category == "personal" {
//            attachment.image = UIImage(named: "persoCat")
//        }
//        else {
//            attachment.image = UIImage(named: "homeCat")
//        }
//        
//        
//        let attachmentString = NSAttributedString(attachment: attachment)
//        let iconText = NSMutableAttributedString(string: "")
//        iconText.append(attachmentString)
//        iconTimeLabel.attributedText = iconText
//        
//        
//        
//        taskCatTimeLabel.text = category
//        
//        
//        taskCellTimeView.layer.borderWidth = 1
//        taskCellTimeView.layer.borderColor = UIColor.lightGray.cgColor
//        taskCellTimeView.layer.cornerRadius = 20
//        
//    }
    
}
