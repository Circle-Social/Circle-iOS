//
//  VerifyVC.swift
//  Circle
//
//  Created by Sharvil Kekre on 1/2/22.
//

import UIKit
import SwiftUI
import Firebase

class VerificationViewController: UIViewController, UITextFieldDelegate {
    
    private var authUser : User? {
        return Auth.auth().currentUser
    }
    
    private let logoView: UIImageView = {
        let logoView = UIImageView()
        logoView.contentMode = .scaleAspectFill
        logoView.image = UIImage(named: "LogoBlack")
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
    
    private let resendButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.baseForegroundColor = UIColor.white
        configuration.baseBackgroundColor = UIColor.systemOrange
        configuration.buttonSize = .large
        configuration.title = "Resend Link"

        let button = UIButton(configuration: configuration, primaryAction: nil)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        ViewUtils().addGradientOne(controller: self)
        view.addSubview(logoView)
        logoView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        logoView.center.x = view.center.x
        logoView.center.y = view.center.y - 300
        
        let verifyMsg = UITextView(frame: CGRect(x: view.center.x-175, y: view.center.y-125, width: 350, height: 300))
        verifyMsg.textColor = UIColor.black
        verifyMsg.backgroundColor = UIColor(white: 1, alpha: 0.0)
        let msg = "We've sent an email to {} to verify your email and activate your account.\n"
        let postActivate = "\nAfter you verify your email, head back to login to access you account."
        let text = msg.replacingOccurrences(of: "{}", with: authUser?.email! ?? "you") + postActivate
        verifyMsg.text = text
        verifyMsg.font = UIFont(name: "PingFangHK-Thin", size: 16)
        view.addSubview(verifyMsg)
        
        view.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        view.addSubview(resendButton)
        resendButton.addTarget(self, action: #selector(resendPressed), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        loginButton.frame = CGRect(
            x: 50,
            y: view.frame.size.height-150-view.safeAreaInsets.bottom,
            width: view.frame.width-100,
            height: 50
        )
        
        resendButton.frame = CGRect(
            x: 50,
            y: view.frame.size.height-75-view.safeAreaInsets.bottom,
            width: view.frame.width-100,
            height: 50
        )
    }
    
    @objc func loginPressed(){
        self.performSegue(withIdentifier: "postVerifyLogin", sender: self)
    }
    
    @objc func resendPressed() {
        self.sendVerificationMail()
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
}
