//
//  FirebaseAuthManager.swift
//  NewApp
//
//  Created by brian Chung on 19/4/2020.
//  Copyright © 2020 brian Chung. All rights reserved.
//
// Helper Class to help users to sign up or sign in at LoginViewController.

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth

class FirebaseAuthManager {
    
    static let sharedInstance = FirebaseAuthManager()
    
    let db = Firestore.firestore()
    var logged_in = false // Used to check if user is logged in or not
    var push_notif_alerts_on = false  // Needed?
    
    var authUser: User! // Current User
    var email = "" // Used to send email valification
    var user_uid = ""
    
    // Signs in user if data exists in FirebaseAuth
    func loginUser(on vc: UIViewController, email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if (error != nil) {
                AlertMaster.invalidFormDetailAlert(on: vc, message: (error?.localizedDescription)!)
                let login_error = "User email or password incorrect."
                AlertMaster.invalidFormDetailAlert(on: vc, message: login_error)
                return
            }
            if let user = Auth.auth().currentUser {
                //Checks if user did confirm account through email
                if !user.isEmailVerified{
                   AlertMaster.showNotVerifiedAlert(on: vc, email: email, password: password)
                    do {
                        try Auth.auth().signOut()
                    }
                    catch {
                        AlertMaster.showBasicAlert(on: vc, with: "Error", message: "Could not sign out.", back: "OK")
                    }
                } else {
                    vc.navigationController?.popToRootViewController(animated: true)
                }
            }
        })
    }

    // Creates user authorization information in FirebaseAuth
    func createUserAuth(on vc: UIViewController,
                        first_name: String,
                        last_name: String,
                        gender: String,
                        email: String,
                        phone_number: String,
                        password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            // Check if error occurred
            if (error != nil) {
                AlertMaster.showBasicAlert(on: vc, with: "Error", message: (error?.localizedDescription)!, back: "Back")
                return
            }
            // Check if email already exists in Firebase Auth
            if (self.alreadyRegistered(email: email)) {
                AlertMaster.showBasicAlert(on: vc, with: "Error", message: "Email address is already in use", back: "OK")
                return
            }
            
            // Send email to check for validity
            self.sendEmail(on: vc, email: email, password: password)

            // Create FirebaseFirestore user
            FirebaseFirestoreManager.sharedInstance.createUser(on: vc,
                                                               first_name: first_name,
                                                               last_name: last_name,
                                                               gender: gender,
                                                               phone_number: phone_number,
                                                               email: email)
            
            // Store the user's docname uid
            self.user_uid = (Auth.auth().currentUser?.uid)!
            
            AlertMaster.showUserRegistrationSent(on: vc, email: email)
        }
    }
    
    //sends verification email to user's email to make sure it is valid
    func sendEmail(on vc: UIViewController, email: String, password: String) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if (error != nil) {
                print("Error in signing in (sendEmail()): \(String(describing: error?.localizedDescription))")
                return
            }
            Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                if (error != nil) {
           //         AlertMaster.showBasicAlert(on: vc, with: "Email Verification", message: "Verification email failed to send: \(String(describing: error?.localizedDescription))", back: "Back")
                    return
                }
           //     AlertMaster.showBasicAlert(on: vc, with: "Verification Email Sent", message: "Check your email for link", back: "Back")
                do {
                    try Auth.auth().signOut()
                }
                catch {
                    print("error in signing out")
                }
                print("Verification email sent to \(email)")
            })
        }
        
    }
    
    //checks if email is already in FirebaseAuth. Fetching providers return devices which uses the
    //email. Thus if provider(s) exist, email already exists as well
    func alreadyRegistered(email: String) -> Bool {
        var registered = false
        print("checking if email already in use")
        Auth.auth().fetchSignInMethods(forEmail: email, completion: {
            (providers, error) in
            
            if let error = error {
                print(error.localizedDescription)
            }
            else if let providers = providers {
                print(providers)
                registered = true
            }
        })
        return registered
    }
    
   
    
}



