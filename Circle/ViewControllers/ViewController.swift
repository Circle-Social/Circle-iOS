//
//  ViewController.swift
//  Circle
//
//  Created by Sharvil Kekre on 1/2/22.
//

import UIKit
import SwiftUI
import Firebase

class ViewController: UIViewController {
    
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
        ViewUtils().addGradientOne(controller: self)
        view.addSubview(logoView)
        logoView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        logoView.center.x = view.center.x
        logoView.center.y = view.center.y - 175
        view.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        view.addSubview(signupButton)
        signupButton.addTarget(self, action: #selector(signupPressed), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Auth.auth().currentUser?.reload(completion: { (err) in
            if err == nil{
                let authUser = Auth.auth().currentUser
                if authUser != nil && authUser!.isEmailVerified {
                    self.performSegue(withIdentifier: "alreadyLoggedIn", sender: nil)
                }
            } else {
                print(err?.localizedDescription as Any)
            }
        })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        loginButton.frame = CGRect(
            x: 50,
            y: view.frame.size.height-150-view.safeAreaInsets.bottom,
            width: view.frame.width-100,
            height: 50
        )
        
        signupButton.frame = CGRect(
            x: 50,
            y: view.frame.size.height-75-view.safeAreaInsets.bottom,
            width: view.frame.width-100,
            height: 50
        )
    }
    
    @objc func loginPressed(){
        guard let loginVC = storyboard?.instantiateViewController(withIdentifier: "login") as? LoginViewController else {
            print("failed to load login from storyboard")
            return
        }
        
        present(loginVC, animated: true)
    }
    
    @objc func signupPressed(){
        guard let signupVC = storyboard?.instantiateViewController(withIdentifier: "signup") as? SignUpViewController else {
            print("failed to load signup from storyboard")
            return
        }
        
        present(signupVC, animated: true)
    }
}
