//
//  ContentView.swift
//  NewApp
//
//  Created by brian Chung on 19/4/2020.
//  Copyright © 2020 brian Chung. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

class DashboardController : UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavBarImage()
        checkIfLoggedIn()
        delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        self.selectedIndex = 0
    }
    
    func addNavBarImage() {
        let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        
        let logoImage = UIImage(named: "call_icon")
        let logoImageView = UIImageView(image: logoImage)
        logoImageView.frame = CGRect(x: 0,y: 0, width: 100, height: 30)
        logoImageView.contentMode = .scaleAspectFit
        logoContainer.addSubview(logoImageView)

        self.navigationItem.titleView = logoContainer
    }
    
    func checkIfLoggedIn() {
        // If no user found in FirebaseAuth, logs out
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
        // Otherwise gets user information
        else{
            //load data from Firebase.
        }
    }
}

// Selectors
extension DashboardController {
    // Instantly logs out if user is not logged in
    @objc func handleLogout() {
        let titleVC = LoginViewController()
        self.navigationController?.pushViewController(titleVC, animated: true)
    }
}
