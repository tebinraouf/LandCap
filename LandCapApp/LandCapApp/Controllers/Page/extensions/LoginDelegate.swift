//
//  LoginDelegate.swift
//  LandCapApp
//
//  Created by Tebin on 9/16/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import Foundation
import UIKit
import Firebase

extension PageController: LoginViewDelegate {

    func signInBtn(email: String?, password: String?) {
        //print("Email: \(email), password: \(password)")
        guard let email = email else { return }
        guard let password = password else { return }
        Auth.auth().signIn(withEmail: email, password: password, completion: { (authDataResult, error) in
            if error != nil {
                self.handling(error)
            } else {
                if (authDataResult?.user.isEmailVerified)! {
                    DispatchQueue.main.async {
                        isLoggedIn = true
                        self.nextController()
                    }
                } else {
                    alert(title: "Email Verification", message: "Please verify your email address.", viewController: self)
                }
            }
        })
    }
    
    func registerBtn(name: String?, email: String?, password: String?) {
        //guard let name = name else { return }
        guard let email = email else { return }
        guard let password = password else { return }
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                    if error == nil {
                        if (Auth.auth().currentUser?.isEmailVerified)! {
                            DispatchQueue.main.async {
                                isLoggedIn = true
                                self.nextController()
                            }
                        } else {
                            alert(title: "Account Created", message: "Please verify your email address.", viewController: self)
                        }
                    } else {
                        self.handling(error)
                    }
                })
            } else {
                self.handling(error)
            }
        })
    }
    
    func forgetPasswordBtn() {
        let requestAlert = UIAlertController(title: "Request Password", message: nil, preferredStyle: .alert)
        requestAlert.addTextField { (textfield) in
            textfield.keyboardType = .emailAddress
            textfield.placeholder = "enter your email here..."
        }
        requestAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        requestAlert.addAction(UIAlertAction(title: "Request New Password", style: .default) { (action) in
            //action.title = "Sent..."
            guard let requestedEmail = requestAlert.textFields?.first?.text else { return }
            Auth.auth().sendPasswordReset(withEmail: requestedEmail) { (error) in
                self.handling(error)
                alert(title: "Sent", message: "Check your email to set your new password.", viewController: self)
            }
        })
        self.present(requestAlert, animated: true)
    }
}
