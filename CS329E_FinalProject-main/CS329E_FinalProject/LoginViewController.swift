//
//  LoginViewController.swift
//  CS329E_FinalProject
//
//  Created by Jennifer Lin on 11/30/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var userIDTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    
    var signIn: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
        
        statusLabel.text = ""
        statusLabel.lineBreakMode = .byWordWrapping
        statusLabel.numberOfLines = 8
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        Auth.auth().addStateDidChangeListener() {
          auth, user in
            if user != nil {
                self.performSegue(withIdentifier: "afterLoginSegue", sender: nil)
                self.userIDTextField.text = nil
                self.passwordTextField.text = nil
              }
            }
        
        confirmPasswordLabel.isHidden = true
        confirmPasswordTextField.isHidden = true
        signInButton.setTitle("Sign In", for: .normal)
        setColor()
    }
    
    override func viewDidAppear(_ animated:Bool) {
        super.viewDidAppear(false)
        setColor()
    }
    
    func setColor() {
        if darkModeSetting {
            overrideUserInterfaceStyle = .dark
        }
        else {
            overrideUserInterfaceStyle = .light
        }
    }

    @IBAction func changeSegmentedControl(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            confirmPasswordLabel.isHidden = true
            confirmPasswordTextField.isHidden = true
            signInButton.setTitle("Sign In", for: .normal)
            signIn = true
        
        case 1:
            confirmPasswordLabel.isHidden = false
            confirmPasswordTextField.isHidden = false
            signInButton.setTitle("Sign Up", for: .normal)
            signIn = false
        
        default:
            confirmPasswordLabel.isHidden = true
            confirmPasswordTextField.isHidden = true
            signInButton.setTitle("Sign In", for: .normal)
            signIn = true
        }
    }
    
    @IBAction func signInButtonPressed(_ sender: Any) {
        if signIn {
            Auth.auth().signIn(withEmail: userIDTextField.text!, password: passwordTextField.text!){
                authResult, error in
                if let error = error as NSError? {
                    self.statusLabel.text = "\(error.localizedDescription)"
                }else{
                    self.statusLabel.text = ""
                    self.performSegue(withIdentifier: "afterLoginSegue", sender: nil)
                }
            }
        }
        else{
            if passwordTextField.text != confirmPasswordTextField.text{
                statusLabel.text = "Passwords must match."
            }
            else{
                Auth.auth().createUser(withEmail: userIDTextField.text!, password: passwordTextField.text!){
                    authResult, error in
                    if let error = error as NSError? {
                        self.statusLabel.text = "\(error.localizedDescription)"
                    }else{
                        self.statusLabel.text = ""
                    }
                }
            }
        }
    }
}
