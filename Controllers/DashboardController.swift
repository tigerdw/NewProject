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
    
    
}
