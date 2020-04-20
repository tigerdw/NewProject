//
//  Sublease.swift
//  NewApp
//
//  Created by Myungyun Chung on 1/27/20.
//  Copyright © 2020 Myungyun Chung. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Sublease {
    var accessibility: [String: Any] = [:]
    var address: String
    var end_duration: String
    var floor: String
    var image_name: String
    var miscellaneous: String
    var owner_email: String // DocumentReference maybe?
    var price: Int
    var start_duration: String
    var tags: [String]
    
    
    var dictionary: [String:Any] {
        return [
            "accessibility" : accessibility,
            "address" : address,
            "end_duration" : end_duration,
            "floor" : floor,
            "image_name" : image_name,
            "miscellaneous": miscellaneous,
            "owner_email" : owner_email,
            "price": price,
            "start_duration" : start_duration,
            "tags": tags
        ]
    }
}

extension Sublease : DocumentSerializable {
    init?(dictionary: [String : Any]) {
        guard let accessibility = dictionary["accessibility"] as? [String: Any],
              let address = dictionary["address"] as? String,
              let end_duration = dictionary["end_duration"] as? String,
              let floor = dictionary["floor"] as? String,
              let image_name = dictionary["image_name"] as? String,
              let miscellaneous = dictionary["miscellaneous"] as? String,
              let owner_email = dictionary["owner_email"] as? String,
              let price = dictionary["price"] as? Int,
              let tags = dictionary["tags"] as? [String],
              let start_duration = dictionary["start_duration"] as? String else {
                return nil
        }
        
        // Initializes the Sublease struct
        self.init(accessibility: accessibility,
                  address: address,
                  end_duration: end_duration,
                  floor: floor,
                  image_name: image_name,
                  miscellaneous: miscellaneous,
                  owner_email: owner_email,
                  price: price,
                  start_duration: start_duration,
                  tags : tags)
                  
    }
}
