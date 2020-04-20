//
//  ContentView.swift
//  NewApp
//
//  Created by brian Chung on 19/4/2020.
//  Copyright © 2020 brian Chung. All rights reserved.
//
// Check if user is logged in. If user is logged in, show the main page. Else, navigate to LoginViewController

import UIKit
import Firebase
import UserNotifications
import FirebaseAuth



class DashboardController : UITabBarController, UITabBarControllerDelegate {
    var view_width = CGFloat()
    var view_height = CGFloat()
    let logoutButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavBarImage()
        checkIfLoggedIn()
        view_width = view.frame.width
        view_height = view.frame.height
        setBackground()
        addLogoutButton()
        setUpConstraints()
        delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        self.selectedIndex = 0
    }
    
    func setBackground() {
        view.backgroundColor = UIColor.lightGray
    }
    
    func addNavBarImage() {
        let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        
        let logoImage = UIImage(named: "templogo")
        let logoImageView = UIImageView(image: logoImage)
        logoImageView.frame = CGRect(x: 0,y: 0, width: 100, height: 30)
        logoImageView.contentMode = .scaleAspectFit
        logoContainer.addSubview(logoImageView)

        self.navigationItem.titleView = logoContainer
    }
    
    func setUpLogoutButton() {
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.backgroundColor = .green
        logoutButton.addTarget(self, action: #selector(showLogoutConfirmation), for: .touchUpInside)
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(UIColor.white, for: .normal)
        logoutButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        logoutButton.contentMode = .scaleAspectFit
        StyleUtilities.styleFilledButton(logoutButton)
        print("upto here")
    }
    
    func addLogoutButton() {
        setUpLogoutButton()
        view.addSubview(logoutButton)
        print("upto here2")
    }
    
    func setUpConstraints() {
        
        logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view_height * 0.1).isActive = true
        logoutButton.widthAnchor.constraint(equalToConstant: view_width * 0.8).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: view_height * 0.05).isActive = true
    }
    
    func checkIfLoggedIn() {
        // If no user found in FirebaseAuth, logs out
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
        // Otherwise gets user information
        else{
            //load data from Firebase. Add code here later.
        }
    }
}

// Selectors
extension DashboardController {
    // Confirms user action to logout
    @objc func showLogoutConfirmation() {
        AlertMaster.showLogoutConfirmationAlert(on: self)
    }
    
    // Instantly logs out if user is not logged in
    @objc func handleLogout() {
        let titleVC = LoginViewController()
        self.navigationController?.pushViewController(titleVC, animated: true)
    }
}
