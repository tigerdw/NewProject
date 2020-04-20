//
//  TitleViewController.swift
//
//  Created by brian Chung on 19/4/2020.
//  Copyright © 2020 brian Chung. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginButton = UIButton(type: .system)
    let signUpButton = UIButton(type: .system)
    let forgotPasswordLabel = UILabel()
    let emptyLineLabel = UILabel()
    let makeAccountLabel = UILabel()
    
    let emailTextField = UITextField()
    let passwordTextField = UITextField()

    let background = UIImage(named: "full-logo")
    let imageView = UIImageView()
    
    var view_width = CGFloat()
    var view_height = CGFloat()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        view_width = view.frame.width
        view_height = view.frame.height

        setBackground()
        addSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @objc func goToSignUpView() {
        //let signUpController = SignUpViewController()
        // Makes the presented view full screen
        // signUpController.modalPresentationStyle = .fullScreen
        // Push the new VC
        //self.navigationController?.pushViewController(signUpController, animated: true)
    }
    
    // Hide keyboard when user touches outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}


// Extension to view controller class to customize UI objects
extension LoginViewController {
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    // Add and set background image
    func setBackground() {
        view.backgroundColor = UIColor.white
        imageView.frame = self.view.frame
        imageView.image = background
        imageView.contentMode =  UIView.ContentMode.scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }
    func addSubviews() {
        setUpSubviews()
        view.addSubview(imageView)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(forgotPasswordLabel)
        view.addSubview(loginButton)
        view.addSubview(emptyLineLabel)
        view.addSubview(makeAccountLabel)
        view.addSubview(signUpButton)
        setUpConstraints()
    }
    
    // Customize UI Components before adding them to main view
    func setUpSubviews() {
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email Address",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor(red:0.75, green:0.75, blue:0.75, alpha:1.00)])
        StyleUtilities.styleTextField(emailTextField)
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor(red:0.75, green:0.75, blue:0.75, alpha:1.00)])
        passwordTextField.isSecureTextEntry = true
        StyleUtilities.styleTextField(passwordTextField)
        
        forgotPasswordLabel.textColor = UIColor(red:0.49, green:0.75, blue:0.93, alpha:1.00)
        forgotPasswordLabel.text = "Forgot password?"
        forgotPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordLabel.font = UIFont.boldSystemFont(ofSize: 12)
        forgotPasswordLabel.adjustsFontForContentSizeCategory = true
        
        emptyLineLabel.textColor = UIColor(red:0.55, green:0.55, blue:0.55, alpha:1.00)
        emptyLineLabel.text = "________________________________________________________"
        emptyLineLabel.textAlignment = .center
        emptyLineLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyLineLabel.font = UIFont.boldSystemFont(ofSize: 12)
        emptyLineLabel.adjustsFontForContentSizeCategory = true
        
        makeAccountLabel.textColor = UIColor(red:0.65, green:0.65, blue:0.65, alpha:1.00)
        makeAccountLabel.text = "Don't have an account yet?"
        makeAccountLabel.textAlignment = .center
        makeAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        makeAccountLabel.font = UIFont.boldSystemFont(ofSize: 12)
        makeAccountLabel.adjustsFontForContentSizeCategory = true
        
        loginButton.frame = self.view.frame
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        loginButton.contentMode = .scaleAspectFit
        loginButton.layer.cornerRadius = 3.0
        StyleUtilities.styleFilledButton(loginButton)
        
        signUpButton.frame = self.view.frame
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.addTarget(self, action: #selector(goToSignUpView), for: .touchUpInside)
        signUpButton.setTitle("Sign Up.", for: .normal)
        signUpButton.setTitleColor(UIColor(red:0.49, green:0.75, blue:0.93, alpha:1.00), for: .normal)
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        signUpButton.contentMode = .scaleAspectFit
        signUpButton.backgroundColor = UIColor.white
    }
    
    @objc func loginButtonTapped() {
        guard  let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            //AlertMaster.invalidFormDetailAlert(on: self, message: "Make sure all forms are filled out")
            return
        }
        //let trimmed_email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        //let trimmed_password = password.trimmingCharacters(in: .whitespacesAndNewlines)
        //FirebaseAuthManager.sharedInstance.loginUser(on: self, email: trimmed_email, password: trimmed_password)
    }
    
    func setUpConstraints() {
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: view_height * 0.20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.50).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.10).isActive = true
        
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: view_height * 0.10).isActive = true
        emailTextField.widthAnchor.constraint(equalToConstant: view.frame.width * 0.85).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: view.frame.height * 0.05).isActive = true
       
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: view_height * 0.03).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: view.frame.width * 0.85).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: view.frame.height * 0.05).isActive = true
       
        forgotPasswordLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        forgotPasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: view_height * 0.03).isActive = true
        forgotPasswordLabel.widthAnchor.constraint(equalToConstant: view.frame.width * 0.30).isActive = true
        forgotPasswordLabel.heightAnchor.constraint(equalToConstant: view.frame.height * 0.02).isActive = true
        
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: forgotPasswordLabel.bottomAnchor, constant: view_height * 0.05).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: view_width * 0.35).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: view_height * 0.08).isActive = true
        
        emptyLineLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emptyLineLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: view_height * 0.03).isActive = true
        emptyLineLabel.widthAnchor.constraint(equalToConstant: view.frame.width * 0.85).isActive = true
        emptyLineLabel.heightAnchor.constraint(equalToConstant: view.frame.height * 0.05).isActive = true
        
        makeAccountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        makeAccountLabel.topAnchor.constraint(equalTo: emptyLineLabel.bottomAnchor, constant: view_height * 0.04).isActive = true
        makeAccountLabel.widthAnchor.constraint(equalToConstant: view.frame.width * 0.85).isActive = true
        makeAccountLabel.heightAnchor.constraint(equalToConstant: view.frame.height * 0.05).isActive = true
        
        signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signUpButton.topAnchor.constraint(equalTo: makeAccountLabel.bottomAnchor, constant: view_height * 0.01).isActive = true
        signUpButton.widthAnchor.constraint(equalToConstant: view_width * 0.20).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: view_height * 0.05).isActive = true
    }
    
}
