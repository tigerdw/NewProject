//
//  User.swift
//  NewApp
//
//  Created by Brian Chung on 4/12/20.
//  Copyright © 2020 Brian Chung. All rights reserved.
//

import Foundation
import FirebaseFirestore

// Rules or blueprints which can be adopted by classes or structs
// Every Sublease must have the following fields
// All sublease classses must follow the protocol
protocol DocumentSerializable {
    init?(dictionary:[String:Any])
}


struct User {
    var first_name: String
    var last_name: String
    var gender: String
    var email: String
    var phone_number: String
    var listed_subleases: Array<String>
    var saved_subleases: Array<String>
    
    var dictionary: [String:Any] {
        return [
            "first_name" : first_name,
            "last_name" : last_name,
            "gender" : gender,
            "email" : email,
            "phone_number" : phone_number,
            "listed_subleases": listed_subleases,
            "saved_subleases": saved_subleases
        ]
    }
}

extension User : DocumentSerializable {
    init?(dictionary: [String : Any]) {
        guard let first_name = dictionary["first_name"] as? String,
              let last_name = dictionary["last_name"] as? String,
              let gender = dictionary["gender"] as? String,
              let email = dictionary["email"] as? String,
              let phone_number = dictionary["phone_number"] as? String,
              let listed_subleases = dictionary["listed_subleases"] as? Array<String>,
              let saved_subleases = dictionary["saved_subleases"] as? Array<String> else {
                return nil
        }
        
        // Initializes the Sublease struct
        self.init(first_name: first_name,
                  last_name: last_name,
                  gender: gender,
                  email: email,
                  phone_number: phone_number,
                  listed_subleases: listed_subleases,
                  saved_subleases: saved_subleases)
    }
}

