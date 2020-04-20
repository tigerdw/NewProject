//
//  AlertMaster.swift
//  NewApp
//
//  Created by brian Chung on 19/4/2020.
//  Copyright © 2020 brian Chung. All rights reserved.
//
// Send alerts to users who do not take correct actions.

import Foundation
import UIKit
import Firebase
import MessageUI
import FirebaseAuth

class AlertMaster: NSObject, MFMailComposeViewControllerDelegate {
    
    // Basic template for an alert
    static func showBasicAlert(on vc: UIViewController, with title: String, message: String, back: String) {
        let showBasicAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        showBasicAlert.addAction(UIAlertAction(title: back, style: .default, handler: nil))
        vc.present(showBasicAlert, animated: true)
    }
    
    // Alert for when textFields aren't all filled out (omit: cellPhone, officePhone)
    static func invalidFormDetailAlert(on vc: UIViewController, message: String) {
        showBasicAlert(on: vc, with: "Invalid Form", message: message, back: "OK")
    }
    
    // Alert to check if user really wants to logout
    static func showLogoutConfirmationAlert(on vc: UIViewController) {
        let message = "Are you sure you want to logout?"
        let showLogoutConfirmationAlert = UIAlertController(title: "Logout", message: message, preferredStyle: .alert)
        showLogoutConfirmationAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        showLogoutConfirmationAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            print("\(String(describing: FirebaseAuthManager.sharedInstance.email)) attempting to sign out")
            do {
                try Auth.auth().signOut()
            }
            catch let logoutError {
                print(logoutError)
            }

            let controller = DashboardController()
            vc.navigationController?.pushViewController(controller, animated: true)
        }))
        vc.present(showLogoutConfirmationAlert, animated: true)
    }
    
    // If user has an email in FirebaseAuth but did not yet verify the email through the link
    static func showNotVerifiedAlert(on vc: UIViewController, email: String, password: String) {
        let showNotVerifiedAlert = UIAlertController(title: "Error", message: "Sorry. Your email address has not yet been verified. Do you want us to send another verification email to \(email)?", preferredStyle: .alert)
        
        showNotVerifiedAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        showNotVerifiedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if (error != nil) {
                    print("Error in signing in (sendEmail()): \(String(describing: error?.localizedDescription))")
                    return
                }
                Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                    if (error != nil) {
                        AlertMaster.showBasicAlert(on: vc, with: "Email Verification", message: "Verification email failed to send: \(String(describing: error?.localizedDescription))", back: "Back")
                        print("Verification email faled to send: \(String(describing: error?.localizedDescription))")
                        return
                    }
                    AlertMaster.showBasicAlert(on: vc, with: "Verification Email Sent", message: "Check your email for link", back: "Back")
                    do {
                        try Auth.auth().signOut()
                    }
                    catch {
                        print("error in signing out")
                    }
                    print("Verification email sent to \(email)")
                })
            }
        }))
        vc.present(showNotVerifiedAlert, animated: true, completion: nil)
    }
    
    // Notifies user of registration email
    static func showUserRegistrationSent(on vc: UIViewController, email: String) {
        let confirm_mssg = "We sent an email to " + email + ". Please check you email and verify with the link we sent."
        
        let confirmAlert = UIAlertController(title: "Thanks!", message: confirm_mssg, preferredStyle: .alert)
        confirmAlert.addAction(UIAlertAction(title: "Okay!", style: .default, handler: { (action) in
            // Go to Home Screen after sign up
            vc.navigationController?.popViewController(animated: true)
        }))
        vc.present(confirmAlert, animated: true, completion: nil)
    }
    
    // Confirms call
    static func showCallingConfirmAlert(on vc: UIViewController, phone_number: String) {
        
        let number = FirebaseFirestoreManager.sharedInstance.currUser.phone_number
  
        guard let phoneNumber = URL(string: "tel://" + number) else {
            print("invalid phone number")
            return
        }
        UIApplication.shared.open(phoneNumber, options: [:], completionHandler: nil)

    }
    
    //couldn't send email
    static func showMailErrorAlert(on vc: UIViewController) {
        showBasicAlert(on: vc, with: "Error", message: "Your email could not be sent", back: "OK")
    }
    
}





