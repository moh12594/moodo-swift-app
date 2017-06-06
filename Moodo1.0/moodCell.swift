//
//  moodCell.swift
//  Moodo1.0
//
//  Created by Mohamed SADAT on 01/06/2017.
//  Copyright © 2017 Mohsadat. All rights reserved.
//

import UIKit

class moodCell: UITableViewCell {
    
    
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var smileyMood: UILabel!
    @IBOutlet weak var textMood: UILabel!
    
    func configureCell(mood: String, moodText: String) {
        
        smileyMood.text = mood
        textMood.text = moodText
        viewCell.layer.borderWidth = 1
        viewCell.layer.borderColor = UIColor.lightGray.cgColor
        viewCell.layer.cornerRadius = 20
    }
    
}
