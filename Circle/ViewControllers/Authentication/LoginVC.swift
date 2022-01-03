//
//  LoginVC.swift
//  Circle
//
//  Created by Sharvil Kekre on 1/2/22.
//

import UIKit
import SwiftUI
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    private let logoView: UIImageView = {
        let logoView = UIImageView()
        logoView.contentMode = .scaleAspectFill
        logoView.image = UIImage(named: "LogoClear")
        return logoView
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
    
    private let forgotPasswordButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.baseForegroundColor = UIColor.white
        configuration.baseBackgroundColor = UIColor(red: 204/255, green: 0, blue: 0, alpha: 1)
        configuration.buttonSize = .large
        configuration.title = "Forgot Password"

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
        
        view.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        view.addSubview(forgotPasswordButton)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordPressed), for: .touchUpInside)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        loginButton.frame = CGRect(
            x: 50,
            y: view.frame.size.height-150-view.safeAreaInsets.bottom,
            width: view.frame.width-100,
            height: 50
        )
        
        forgotPasswordButton.frame = CGRect(
            x: 50,
            y: view.frame.size.height-75-view.safeAreaInsets.bottom,
            width: view.frame.width-100,
            height: 50
        )
    }
    
    
    @objc func loginPressed() {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
            if error == nil {
                print("successfully retrieved user")
                self.loginUser()
            } else {
                let alertController = UIAlertController(title: "Invalid Email/Password", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)

                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    
    func loginUser() {
        Auth.auth().currentUser?.reload(completion: { (error) in
            if let error = error {
                print(error)
            } else {
                if Auth.auth().currentUser != nil && Auth.auth().currentUser!.isEmailVerified {
                    print("successfully logged in!")
                    self.performSegue(withIdentifier: "successfulLogin", sender: self)
                } else {
                    let alertController = UIAlertController(title: "Unverified Email", message: "Follow email link to activate account", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)

                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        })
    }
    
    
    @objc func forgotPasswordPressed() {
        self.performSegue(withIdentifier: "forgotPassword", sender: self)
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
