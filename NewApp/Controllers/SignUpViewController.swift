//
//  SignUpViewController.swift
//  NewApp
//
//  Created by brian Chung on 19/4/2020.
//  Copyright © 2020 brian Chung. All rights reserved.
//
// User Sign up Page

import UIKit

class SignUpViewController: UIViewController, UITextViewDelegate {
    let background = UIImage(named: "templogo")
    let imageView = UIImageView()
    let signupIntroLabel = UILabel()
    let policyLabel = UILabel()
    
    let firstNameTextField = UITextField()
    let lastNameTextField = UITextField()
    let genderTextField = UITextField() 
    let phoneNumberTextField = UITextField()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let signUpButton = UIButton(type: .system)
    let backButton = UIButton(type: .system)
    
    var view_width = CGFloat()
    var view_height = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("At SignUpViewController")
        
        view_width = view.frame.width
        view_height = view.frame.height

        setBackground()
        addSubviews()
    }
    
    // Check gender form is filled out correctly
    func checkGenderForm() -> Bool? {
        let trimmed_gender = genderTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed_gender == "Male" ||
           trimmed_gender == "Female" ||
           trimmed_gender == "Other" {
            return true
        }
        return false
    }

    // Checks validation for field inputs
    // Correct input returns nil
    // Incorrect input returns error message
    func validateFields() -> String? {
        // Check all fields are filled in (ignore whitespaces/newlines)
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
           lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
           genderTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
           phoneNumberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
           emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
           passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Fields are not all filled in."
        }
        
        // Check gender is correct option
        if checkGenderForm() == false {
            return "Please make sure gender is either Male, Female, or Other."
        }
        
        
        // Check phone number format
        let trimmed_phone_number = phoneNumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if FormUtilities.isPhoneNumberValid(trimmed_phone_number) == false {
            return "Please make sure phone number is in the required format: ###-###-####"
        }
        
        // Check if password is secure
        let trimmed_password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if FormUtilities.isPasswordValid(trimmed_password) == false {
            // Failed regex check
            return "Please make sure your password is at least 8 characters and contains a " +
                   "special character and a number."
        }
        
        return nil
    }
    
    
    // Prevent auto screen rotation
    override open var shouldAutorotate: Bool {
        return false
    }
    
    // Hide keyboard when user touches outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

// Selectors
extension SignUpViewController {
    
    @objc func signUpButtonTapped() {
        print("Sign Up tapped")
        // Validate fields
        let error_msg = validateFields()
        
        if error_msg != nil {
            // Field validation returned error message
            AlertMaster.invalidFormDetailAlert(on: self, message: error_msg!)
            return
        }
        
        // Create User in Firebase Auth
        let trimmed_first_name = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmed_last_name = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmed_gender = genderTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmed_phone_number = phoneNumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmed_email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmed_password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        FirebaseAuthManager.sharedInstance.createUserAuth(on: self,
                                                          first_name: trimmed_first_name,
                                                          last_name: trimmed_last_name,
                                                          gender: trimmed_gender,
                                                          email: trimmed_email,
                                                          phone_number: trimmed_phone_number,
                                                          password: trimmed_password)
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

// Extension to view controller to customize UI objects
extension SignUpViewController {
    
    func setBackground() {
        self.view.backgroundColor = UIColor.white

        imageView.frame = self.view.frame
        imageView.image = background
        imageView.contentMode =  UIView.ContentMode.scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addSubviews() {
        setUpSubviews()
        
        view.addSubview(imageView)
        view.addSubview(signupIntroLabel)
        view.addSubview(policyLabel)
        view.addSubview(firstNameTextField)
        view.addSubview(lastNameTextField)
        view.addSubview(genderTextField)
        view.addSubview(phoneNumberTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signUpButton)

        
        setUpConstraints()
    }
    
    func setUpSubviews() {
        signupIntroLabel.textColor = UIColor(red:0.65, green:0.65, blue:0.65, alpha:1.00)
        signupIntroLabel.textAlignment = .center
        signupIntroLabel.numberOfLines = 0
        signupIntroLabel.text = "Sign up to see more posts"
        signupIntroLabel.translatesAutoresizingMaskIntoConstraints = false
        signupIntroLabel.font = UIFont.boldSystemFont(ofSize: 14)
        signupIntroLabel.adjustsFontForContentSizeCategory = true
        
        let attributedString1 = NSAttributedString(string: "By signing up, you agree to our\n", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red:0.65, green:0.65, blue:0.65, alpha:1.00)])
        let attributedString2 = NSAttributedString(string: "Terms & Privacy Policy", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red:0.45, green:0.45, blue:0.45, alpha:1.00)])
        let mutableString = NSMutableAttributedString()
        mutableString.append(attributedString1)
        mutableString.append(attributedString2)
        policyLabel.textAlignment = .center
        policyLabel.numberOfLines = 0
        policyLabel.attributedText = mutableString
        policyLabel.translatesAutoresizingMaskIntoConstraints = false
        policyLabel.font = UIFont.boldSystemFont(ofSize: 14)
        policyLabel.adjustsFontForContentSizeCategory = true
        
        firstNameTextField.attributedPlaceholder = NSAttributedString(string: "First Name",
                                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        StyleUtilities.styleTextField(firstNameTextField)
        
        lastNameTextField.attributedPlaceholder = NSAttributedString(string: "Last Name",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        StyleUtilities.styleTextField(lastNameTextField)
        
        genderTextField.attributedPlaceholder = NSAttributedString(string: "Gender (Male | Female | Other)",
                                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        StyleUtilities.styleTextField(genderTextField)
        
        phoneNumberTextField.attributedPlaceholder = NSAttributedString(string: "Phone Number (i.e. 111-222-3333)",
                                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        StyleUtilities.styleTextField(phoneNumberTextField)
        
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email Address",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        StyleUtilities.styleTextField(emailTextField)
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        passwordTextField.isSecureTextEntry = true
        StyleUtilities.styleTextField(passwordTextField)
                
        signUpButton.frame = self.view.frame
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(UIColor.white, for: .normal)
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        signUpButton.contentMode = .scaleAspectFit
        signUpButton.layer.cornerRadius = 3.0
        StyleUtilities.styleFilledButton(signUpButton)
    }
 
    func setUpConstraints() {
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: view_height * 0.10).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.50).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.10).isActive = true
        
        signupIntroLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signupIntroLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: view_height * 0.005).isActive = true
        signupIntroLabel.widthAnchor.constraint(equalToConstant: view.frame.width * 0.85).isActive = true
        signupIntroLabel.heightAnchor.constraint(equalToConstant: view.frame.height * 0.05).isActive = true
        
        firstNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        firstNameTextField.topAnchor.constraint(equalTo: signupIntroLabel.bottomAnchor, constant: view_height * 0.04).isActive = true
        firstNameTextField.widthAnchor.constraint(equalToConstant: view.frame.width * 0.85).isActive = true
        firstNameTextField.heightAnchor.constraint(equalToConstant: view.frame.height * 0.05).isActive = true
        
        lastNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: view_height * 0.03).isActive = true
        lastNameTextField.widthAnchor.constraint(equalToConstant: view.frame.width * 0.85).isActive = true
        lastNameTextField.heightAnchor.constraint(equalToConstant: view.frame.height * 0.05).isActive = true
        
        genderTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        genderTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: view_height * 0.03).isActive = true
        genderTextField.widthAnchor.constraint(equalToConstant: view.frame.width * 0.85).isActive = true
        genderTextField.heightAnchor.constraint(equalToConstant: view.frame.height * 0.05).isActive = true
        
        phoneNumberTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        phoneNumberTextField.topAnchor.constraint(equalTo: genderTextField.bottomAnchor, constant: view_height * 0.03).isActive = true
        phoneNumberTextField.widthAnchor.constraint(equalToConstant: view.frame.width * 0.85).isActive = true
        phoneNumberTextField.heightAnchor.constraint(equalToConstant: view.frame.height * 0.05).isActive = true
        
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextField.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: view_height * 0.03).isActive = true
        emailTextField.widthAnchor.constraint(equalToConstant: view.frame.width * 0.85).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: view.frame.height * 0.05).isActive = true
        
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: view_height * 0.03).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: view.frame.width * 0.85).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: view.frame.height * 0.05).isActive = true
        
        signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signUpButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: view_height * 0.03).isActive = true
        signUpButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.35).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: view.frame.height * 0.08).isActive = true
        
        policyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        policyLabel.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: view_height * 0.04).isActive = true
        policyLabel.widthAnchor.constraint(equalToConstant: view.frame.width * 0.85).isActive = true
        policyLabel.heightAnchor.constraint(equalToConstant: view.frame.height * 0.05).isActive = true
    }
    
}
