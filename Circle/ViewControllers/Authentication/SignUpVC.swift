//
//  SignUpVC.swift
//  Circle
//
//  Created by Sharvil Kekre on 1/2/22.
//

import UIKit
import SwiftUI
import Firebase

class SignUpViewController: UIViewController, UITextFieldDelegate {
        
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var displayName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordConfirm: UITextField!
    
    private var authUser : User? {
        return Auth.auth().currentUser
    }
    
    private let logoView: UIImageView = {
        let logoView = UIImageView()
        logoView.contentMode = .scaleAspectFill
        logoView.image = UIImage(named: "LogoClear")
        return logoView
    }()
    
    private let signupButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.baseForegroundColor = UIColor.white
        configuration.baseBackgroundColor = UIColor.systemOrange
        configuration.buttonSize = .large
        configuration.title = "Sign Up"

        let button = UIButton(configuration: configuration, primaryAction: nil)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addGradient()
        view.addSubview(logoView)
        logoView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        logoView.center.x = view.center.x
        logoView.center.y = view.center.y - 300
        
        view.addSubview(signupButton)
        signupButton.addTarget(self, action: #selector(signupPressed), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        signupButton.frame = CGRect(
            x: 50,
            y: view.frame.size.height-75-view.safeAreaInsets.bottom,
            width: view.frame.width-100,
            height: 50
        )
    }
    
    
    @objc func signupPressed(){
        if password.text != passwordConfirm.text {
            let alertController = UIAlertController(title: "Password Do Not Match", message: "Please re-type password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        } else if emptyFields() {
            let alertController = UIAlertController(title: "Invalid Entry", message: "All fields must be populated", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            Auth.auth().createUser(withEmail: email.text!, password: password.text!){ (user, error) in
                if error == nil {
                    print("User succcessfully created!")
                    self.sendVerificationMail()
                    let userClient = UserClient(email: self.email.text!, displayName: self.displayName.text!, uid: self.authUser!.uid)
                    userClient.create()
                    self.performSegue(withIdentifier: "verifySignUp", sender: self)
                }
                else{
                    let alertController = UIAlertController(title: "Sign Up Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    print("Error when creating user")
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    func emptyFields() -> Bool {
        let fields = [email, displayName, password, passwordConfirm]
        for field in fields {
            if field!.text == "" {
                return true
            }
        }
        return false
    }
    
    
    func sendVerificationMail() {
        if authUser != nil && !authUser!.isEmailVerified {
            authUser!.sendEmailVerification(completion: { (error) in
                if error == nil {
                    print("sent verification email")
                } else {
                    let alertController = UIAlertController(title: "Verification Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    print("Error when sending verification email")
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            })
        }
        else {
            // Either the user is not available, or the user is already verified.
        }
    }

    func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [
            UIColor.white.cgColor,
            UIColor.yellow.cgColor,
            UIColor.orange.cgColor,
            UIColor.red.cgColor
        ]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
