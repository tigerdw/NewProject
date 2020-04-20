//
//  Utilities.swift
//
//  Created by brian Chung on 19/4/2020.
//  Copyright © 2020 brian Chung. All rights reserved.
//

import Foundation
import UIKit

class StyleUtilities {
    
    static func styleTextField(_ textfield:UITextField) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textfield.frame.height))
        textfield.leftView = paddingView
        textfield.leftViewMode = UITextField.ViewMode.always
        textfield.textColor = UIColor.black
        textfield.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.00)
        textfield.font = UIFont(name: "Helvetica", size: 14)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.layer.cornerRadius = 5.0
        textfield.textAlignment = .left
        textfield.autocorrectionType = .no
        textfield.autocapitalizationType = .none
        textfield.layer.borderColor = UIColor(red:0.75, green:0.75, blue:0.75, alpha:1.00).cgColor
        textfield.layer.borderWidth = 1
    }
    
    static func styleFilledButton(_ button:UIButton) {
        // Filled rounded corner style
        button.backgroundColor = UIColor.init(red: 40/255,
                                              green: 105/255,
                                              blue: 235/255,
                                              alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    
    static func styleHollowButton(_ button:UIButton) {
        // Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
    }
}
