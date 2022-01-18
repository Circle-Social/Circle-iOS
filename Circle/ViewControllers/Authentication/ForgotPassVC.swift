//
//  ForgotPassVC.swift
//  Circle
//
//  Created by Sharvil Kekre on 1/2/22.
//

import UIKit
import SwiftUI
import Firebase

class ForgotPassController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    
    private let logoView: UIImageView = {
        let logoView = UIImageView()
        logoView.contentMode = .scaleAspectFill
        logoView.image = UIImage(named: "LogoClear")
        return logoView
    }()
    
    private let emailPrompt: UITextView = {
        let emailPrompt = UITextView()
        emailPrompt.textColor = UIColor.black
        emailPrompt.backgroundColor = UIColor(white: 1, alpha: 0.0)
        let msg = "Enter the email associated with your account..."
        emailPrompt.text = msg
        emailPrompt.font = UIFont(name: "PingFangHK-Thin", size: 21)
        emailPrompt.textAlignment = .center
        return emailPrompt
    }()
    
    private let emailField: UITextField = {
        let emailField = UITextField()
        emailField.placeholder = "Email"
        emailField.textAlignment = .center
        emailField.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5);
        emailField.textColor = UIColor.black
        emailField.borderStyle = UITextField.BorderStyle.roundedRect
        emailField.autocapitalizationType = UITextAutocapitalizationType.none
        emailField.spellCheckingType = UITextSpellCheckingType.no
        emailField.font = UIFont(name: "PingFangHK-Thin", size: 16)
        return emailField
    }()
    
    private let submitButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.baseForegroundColor = UIColor.white
        configuration.baseBackgroundColor = UIColor.systemOrange
        configuration.buttonSize = .large
        configuration.title = "Submit"

        let button = UIButton(configuration: configuration, primaryAction: nil)
        return button
    }()
    
    private let loginButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.baseForegroundColor = UIColor.white
        configuration.baseBackgroundColor = UIColor.systemOrange
        configuration.buttonSize = .large
        configuration.title = "Login"

        let button = UIButton(configuration: configuration, primaryAction: nil)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        ViewUtils().addGradientOne(controller: self)
        view.addSubview(logoView)
        logoView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        logoView.center.x = view.center.x
        logoView.center.y = view.center.y - 300
        
        view.addSubview(emailPrompt)
        emailPrompt.frame = CGRect(x: 57, y: view.center.y-125, width: 350, height: 300)
        emailPrompt.center = view.center
        
        view.addSubview(emailField)
        emailField.frame = CGRect(x: 57, y: 315, width: 300, height: 34)
        emailField.center = view.center
        
        view.addSubview(submitButton)
        submitButton.addTarget(self, action: #selector(submitPressed), for: .touchUpInside)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        submitButton.frame = CGRect(
            x: 50,
            y: view.frame.size.height-75-view.safeAreaInsets.bottom,
            width: view.frame.width-100,
            height: 50
        )
        
        loginButton.frame = CGRect(
            x: 50,
            y: view.frame.size.height-75-view.safeAreaInsets.bottom,
            width: view.frame.width-100,
            height: 50
        )
    }
    
    
    @objc func submitPressed() {
        sendResetLink()
    }
    
    
    func sendResetLink() {
        Auth.auth().sendPasswordReset(withEmail: emailField.text!) { (error) in
            if error == nil {
                let email = self.emailField.text!
                self.emailField.removeFromSuperview()
                self.emailPrompt.removeFromSuperview()
                self.submitButton.removeFromSuperview()
                let resetMsg = UITextView(frame: CGRect(x: 57, y: self.view.center.y-125, width: 350, height: 300))
                resetMsg.textColor = UIColor.black
                resetMsg.backgroundColor = UIColor(white: 1, alpha: 0.0)
                let msg = "We've sent an email to {} to reset the password for your account.\n"
                let postActivate = "\nAfter you reset your password, head back to login to access you account."
                let text = msg.replacingOccurrences(of: "{}", with: email) + postActivate
                resetMsg.text = text
                resetMsg.font = UIFont(name: "PingFangHK-Thin", size: 16)
                self.view.addSubview(resetMsg)
                self.view.addSubview(self.loginButton)
                self.loginButton.addTarget(self, action: #selector(self.loginPressed), for: .touchUpInside)
            } else {
                let alertController = UIAlertController(title: "Reset Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                print("Error when sending password reset email")
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    
    @objc func loginPressed() {
        self.performSegue(withIdentifier: "forgotPassLogin", sender: self)
    }
}
