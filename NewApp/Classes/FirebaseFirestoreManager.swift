//
//  FirebaseFirestoreManager.swift
//  NewApp
//
//  Created by brian Chung on 19/4/2020.
//  Copyright © 2020 brian Chung. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

class FirebaseFirestoreManager {
    static let sharedInstance = FirebaseFirestoreManager()
    
    let db = Firestore.firestore()  // Firebase
    var subleases_array = [Sublease]() // To display subleases in tableview
    var subleases_size = 0  // number of subleases
    var doc_name = ""  //
    
    var currUser: User! // To store selected user's info
    var currSublease: Sublease!  // To store selected sublease info
    
    
    // creates and returns live snapshot of array of documents of subleases
    func loadData(ordering: String, tags: [String]) {
        let database = db.collection("Subleases")
        var query = database.whereField("tags", arrayContains: "base")
        for tag in tags {
            let check = "accessibility." + tag
            query = query.whereField(check, isEqualTo: true)
        }
        query.order(by: ordering).getDocuments { (querySnapshot, err) in
            // Check if an error occurred while retrieving documents
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(err!.localizedDescription)")
                return
            }
            // Set sublease array and size to documents and size respectively
            let dictionaries = documents.compactMap({$0.data()})
            self.subleases_array = dictionaries.compactMap({Sublease(dictionary: $0)})
            self.subleases_size = self.subleases_array.count
            print("Size of sublease array: \(self.subleases_size)")
            
            // Set table reloader
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadCollectionView"), object: nil)
        }
    }
    
    // Creates or overwrites a user document in FirebaseFirestore
    func createUser(on vc: UIViewController,
                    first_name: String,
                    last_name: String,
                    gender: String,
                    phone_number: String,
                    email: String) {
        
        FirebaseAuthManager.sharedInstance.user_uid = (Auth.auth().currentUser?.uid)!
        print("Current User UID: \(FirebaseAuthManager.sharedInstance.user_uid)")
        db.collection("Users").document(email).setData(["first_name": first_name,
                                                        "last_name": last_name,
                                                        "gender": gender,
                                                        "email": email,
                                                        "phone_number": phone_number,
                                                        "listed_subleases": [],
                                                        "saved_subleases": []]) { err in
            if let err = err {
                AlertMaster.showBasicAlert(on: vc,
                                           with: "Error",
                                           message: err.localizedDescription,
                                           back: "OK")
                return
            }
            print("Created user document for: \(email)")
        }
    }
    
    // Store user's Firestore data in sharedInstance User variable
    func getUserData() {
        if let user = Auth.auth().currentUser {
            // Get necessary FirebaseAuthManager Data
            print("Getting User Data")
            FirebaseAuthManager.sharedInstance.user_uid = user.uid
            print("Current User UID: \(FirebaseAuthManager.sharedInstance.user_uid)")
            print("Current User Email: \(user.email!)")
            FirebaseAuthManager.sharedInstance.email = user.email!
            
            // Get user document information
            let user_doc_ref = db.collection("Users").document(user.email!)
            user_doc_ref.getDocument { (document, error) in
                if let document = document, document.exists {
                    // Set current user struct to correct user document data
                    FirebaseAuthManager.sharedInstance.authUser = User(dictionary: document.data()!)
                }
                else {
                    print("Document does not exist: \(error!)")
                }
            }
        }
    }
    
    // Get sublease owner's user information
    func getSubleaseOwnerData(email: String) {
        // Get sublease owner document information
        let user_doc_ref = db.collection("Users").document(email)
        user_doc_ref.getDocument { (document, error) in
            if let document = document, document.exists {
                // Set current user struct to correct user document data
                FirebaseFirestoreManager.sharedInstance.currUser = User(dictionary: document.data()!)
                
                // Set sublease owner
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "setSubleaseOwner"), object: nil)
            }
            else {
                print("Document does not exist: \(error!)")
            }
        }
    }
    
    // Creates or overwrites a sublease document in FirebaseFirestore
    func createSublease(on vc: UIViewController, sublease: Sublease) {
        db.collection("Subleases").document(sublease.address).setData(
            ["accessibility" : sublease.accessibility,
             "address" : sublease.address,
             "end_duration" : sublease.end_duration,
             "floor" : sublease.floor,
             "image_name" : sublease.image_name,
             "miscellaneous": sublease.miscellaneous,
             "owner_email" : sublease.owner_email,
             "price": sublease.price,
             "start_duration" : sublease.start_duration,
             "tags" : sublease.tags]) { err in
            if let err = err {
                AlertMaster.showBasicAlert(on: vc,
                                           with: "Error",
                                           message: err.localizedDescription,
                                           back: "OK")
                return
            }
            print("Created sublease for address: \(sublease.address)")
        }
    }
    
    // For testing only
    func createTestSubleases() {
        let subleases_ref = db.collection("Subleases")
        
        var accessibility = ["access": true,
                             "elevator": true,
                             "ramp": false,
                             "pets": false,
                             "shoes_inside": false]
        var address = "4220 Saginaw Ct."
        var end_duration = "2021 Winter"
        var floor = "Basement"
        var image_name = "apt1"
        var miscellaneous = "N/A"
        var owner_email = "myungyun@umich.edu"
        var price = 230
        var start_duration = "2020 Winter"
        let tags = ["base"]
        subleases_ref.document(address).setData(
            ["accessibility" : accessibility,
             "address" : address,
             "end_duration" : end_duration,
             "floor" : floor,
             "image_name" : image_name,
             "miscellaneous": miscellaneous,
             "owner_email" : owner_email,
             "price": price,
             "start_duration" : start_duration,
             "tags" : tags]) { err in
            if err != nil {
                print(err!)
            }
//            print("Created sublease for address: \(address)")
        }

        accessibility = ["access": true,
                         "elevator": true,
                         "ramp": true,
                         "pets": true,
                         "shoes_inside": true]
        address = "239 Geddes Ave."
        end_duration = "2020 Summer"
        floor = "First"
        image_name = "apt2"
        miscellaneous = "N/A"
        owner_email = "myungyun@umich.edu"
        price = 1200
        start_duration = "2020 Summer"
        
        subleases_ref.document(address).setData(
        ["accessibility" : accessibility,
         "address" : address,
         "end_duration" : end_duration,
         "floor" : floor,
         "image_name" : image_name,
         "miscellaneous": miscellaneous,
         "owner_email" : owner_email,
         "price": price,
         "start_duration" : start_duration,
         "tags" : tags]) { err in
//            print("Created sublease for address: \(address)")
        }

        accessibility = ["access": true,
                         "elevator": false,
                         "ramp": false,
                         "pets": false,
                         "shoes_inside": false]
        address = "1120 Linden St."
        end_duration = "2022 Winter"
        floor = "First"
        image_name = "apt3"
        miscellaneous = "N/A"
        owner_email = "myungyun@umich.edu"
        price = 680
        start_duration = "2020 Summer"
        
        subleases_ref.document(address).setData(
        ["accessibility" : accessibility,
         "address" : address,
         "end_duration" : end_duration,
         "floor" : floor,
         "image_name" : image_name,
         "miscellaneous": miscellaneous,
         "owner_email" : owner_email,
         "price": price,
         "start_duration" : start_duration,
         "tags" : tags]) { err in
//            print("Created sublease for address: \(address)")
        }

        address = "1337 Wilmot St."
        end_duration = "2023 Winter"
        image_name = "apt4"
        floor = "Second"
        miscellaneous = "N/A"
        owner_email = "myungyun@umich.edu"
        price = 500
        start_duration = "2020 Spring"
        subleases_ref.document(address).setData(
            ["accessibility" : accessibility,
             "address" : address,
             "end_duration" : end_duration,
             "floor" : floor,
             "image_name" : image_name,
             "miscellaneous": miscellaneous,
             "owner_email" : owner_email,
             "price": price,
             "start_duration" : start_duration,
             "tags" : tags]) { err in
//            print("Created sublease for address: \(address)")
        }

        address = "2250 S Forest Ave."
        end_duration = "2020 Summer"
        floor = "First"
        image_name = "apt5"
        miscellaneous = "N/A"
        owner_email = "myungyun@umich.edu"
        price = 400
        start_duration = "2020 Summer"
        subleases_ref.document(address).setData(
        ["accessibility" : accessibility,
         "address" : address,
         "end_duration" : end_duration,
         "floor" : floor,
         "image_name" : image_name,
         "miscellaneous": miscellaneous,
         "owner_email" : owner_email,
         "price": price,
         "start_duration" : start_duration,
         "tags" : tags]) { err in
//            print("Created sublease for address: \(address)")
        }
    }
}
