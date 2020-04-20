//
//  PasswordUtilities.swift
//  NewApp
//
//  Created by brian Chung on 19/4/2020.
//  Copyright © 2020 brian Chung. All rights reserved.
//
// Utilities to help users sign up
//

import Foundation
import UIKit

class FormUtilities {
    
    static func isPasswordValid(_ password : String) -> Bool {
        /*
         (?=.*[a-z])                - Ensure string has one character.
         (?=.[$@$#!%?&])            - Ensure string has one special character.
         {8,}                       - Ensure password length is 8.
         */
        let password_regex = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", password_regex)
        return passwordTest.evaluate(with: password)
        
    }
    
    static func isPhoneNumberValid(_ phone_number : String) -> Bool {
        // Format: ###-###-####
        let phone_regex = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phone_regex)
        return phoneTest.evaluate(with: phone_number)
    }
}

