//
//  Utilities.swift
//  Moodo1.0
//
//  Created by Mohamed SADAT on 22/05/2017.
//  Copyright © 2017 Mohsadat. All rights reserved.
//

import Foundation
import UIKit


class Utilities {
    
    func showAlert(title: String, message: String, vc: UIViewController) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        vc.present(alert, animated: true, completion: nil)
    }
    
    
    func displayTasksAccordingToMood(task: String, difficulty: String, category: String, taskTable: inout [String], difficultyTable: inout [String], categoryTable: inout [String], displayTable: UITableView, mood: String, keysTable: inout [String], key: String) {
        
        
        if ( mood == "😄"  || mood == "😊") {
            if (difficulty == "Hard" || difficulty == "Medium") {
                taskTable.append(task)
                difficultyTable.append(difficulty)
                categoryTable.append(category)
                keysTable.append(key)
                displayTable.reloadData()
            }
        }
        
        if (mood == "😤"  || mood == "😞") {
            if (difficulty == "Easy") {
                taskTable.append(task)
                difficultyTable.append(difficulty)
                categoryTable.append(category)
                keysTable.append(key)
                displayTable.reloadData()
            }
        }
        
        
        if (mood == "😐") {
            if (difficulty == "Medium" || difficulty == "Easy") {
                taskTable.append(task)
                difficultyTable.append(difficulty)
                categoryTable.append(category)
                keysTable.append(key)
                displayTable.reloadData()
            }
        }
        
        
        if (mood == "😶") {
            taskTable.append(task)
            difficultyTable.append(difficulty)
            categoryTable.append(category)
            keysTable.append(key)
            displayTable.reloadData()
        }

        
    }
    
    
    
//    func displayTasksAccordingToTime(task: String, difficulty: String, category: String, taskTable: inout [String], difficultyTable: inout [String], categoryTable: inout [String], displayTable: UITableView, mood: String) {
//        
//        
//        if ( mood == "😄"  || mood == "😊") {
//            if (difficulty == "Easy") {
//                taskTable.append(task)
//                difficultyTable.append(difficulty)
//                categoryTable.append(category)
//                displayTable.reloadData()
//            }
//        }
//        
//        if (mood == "😤"  || mood == "😞") {
//            if (difficulty == "Medium") {
//                taskTable.append(task)
//                difficultyTable.append(difficulty)
//                categoryTable.append(category)
//                displayTable.reloadData()
//            }
//        }
//        
//        
//        if (mood == "😐") {
//            if (difficulty == "Hard") {
//                taskTable.append(task)
//                difficultyTable.append(difficulty)
//                categoryTable.append(category)
//                displayTable.reloadData()
//            }
//        }
//        
//        
//        if (mood == "😶") {
//            taskTable.append(task)
//            difficultyTable.append(difficulty)
//            categoryTable.append(category)
//            displayTable.reloadData()
//        }
//        
//        
//    }
//    
    
    
    
    
    func moodPassedToEmoji(moodText: String) -> String {
        
        var moodEmoji = ""
        
        if (moodText == "Excited") {
            moodEmoji = "😄"
        }
        if (moodText == "Happy") {
            moodEmoji = "😊"
        }
        if (moodText == "Angry") {
            moodEmoji = "😤"
        }
        if (moodText == "Sad") {
            moodEmoji = "😞"
        }
        if (moodText == "Jaded") {
            moodEmoji = "😐"
        }
        if (moodText == "Neutral") {
            moodEmoji = "😶"
        }
        
        return moodEmoji
    }
    
}
