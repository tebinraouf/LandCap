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
        Auth.auth().signIn(withEmail: email, password: password, completion: { (authResult, error) in
            if error != nil {
                self.handling(error)
            } else {
                if (authResult?.user.isEmailVerified)! {
                    //Get the Current User ID Saved.
                    User.session.currentUserID = (authResult?.user.uid)!
                    
                    //Move to the HomeController
                    DispatchQueue.main.async {
                        User.session.isSignedIn = true
                        self.nextController()
                    }
                } else {
                    let email = NSLocalizedString("Email Verification", comment: "Email Verification")
                    let emailVer = NSLocalizedString("Email Ver Message", comment: "Verify your account")
                    alert(title: email, message: emailVer, viewController: self)
                }
            }
        })
    }
    
    func registerBtn(name: String?, email: String?, password: String?) {
        guard let name = name else { return }
        guard let email = email else { return }
        guard let password = password else { return }
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (authResult, error) in
            if error == nil {
                //Store the user's name in the database
                if let authResult = authResult {
                    //set the initial user details for database
                    let user = CapUser()
                    user.Key = authResult.user.uid
                    user.isAnonymous = false
                    user.photoLimit = 100
                    user.Name = name
                    //fill database with initial values
                    let capDatabase = CapDatabase(user: user)
                    capDatabase.add()
                }
                //Check if account is verified.
                Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                    if error == nil {
                        if (Auth.auth().currentUser?.isEmailVerified)! {
                            DispatchQueue.main.async {
                                User.session.isSignedIn = true
                                self.nextController()
                            }
                        } else {
                            let account = NSLocalizedString("Account Created", comment: "Email Verification")
                            let emailVer = NSLocalizedString("Email Ver Message", comment: "Verify your account")
                            alert(title: account, message: emailVer, viewController: self)
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
        let newPass = NSLocalizedString("Request Password", comment: "Request New Password")
        let requestNewPass = NSLocalizedString("Request New Password", comment: "Request New Password")
        let emailHereText = NSLocalizedString("Email Placeholder", comment: "Email placeholder")
        
        let requestAlert = UIAlertController(title: newPass, message: nil, preferredStyle: .alert)
        requestAlert.addTextField { (textfield) in
            textfield.keyboardType = .emailAddress
            textfield.placeholder = emailHereText
        }
        requestAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        requestAlert.addAction(UIAlertAction(title: requestNewPass, style: .default) { (action) in
            //action.title = "Sent..."
            guard let requestedEmail = requestAlert.textFields?.first?.text else { return }
            Auth.auth().sendPasswordReset(withEmail: requestedEmail) { (error) in
                self.handling(error)
                alert(title: "Sent", message: "Check your email to set your new password.", viewController: self)
            }
        })
        self.present(requestAlert, animated: true)
    }
    
    func skipBtn() {
        let skipTitle = NSLocalizedString("Skip Title", comment: "Skip Title goes here")
        let skipMessage = NSLocalizedString("Skip Message", comment: "Skip message goes here")
        let skipCancel = NSLocalizedString("Skip Cancel", comment: "Skip cancel goes here")
        let skipOkay = NSLocalizedString("Skip Okay", comment: "Skip okay goes here")
        
        let requestAlert = UIAlertController(title: skipTitle, message: skipMessage, preferredStyle: .alert)
        
        requestAlert.addAction(UIAlertAction(title: skipCancel, style: .cancel, handler: nil))
        requestAlert.addAction(UIAlertAction(title: skipOkay, style: .default) { (action) in
            
            Auth.auth().signInAnonymously() { (authResult, error) in
                if error == nil {
                    if let authResult = authResult {
                        let user = authResult.user
                        let uid = user.uid
                        //set the initial user details for database
                        let capUser = CapUser()
                        capUser.Name = "Guest"
                        capUser.isAnonymous = true
                        capUser.photoLimit = 10
                        capUser.Key = uid
                        //fill database with initial values
                        let capDatabase = CapDatabase(user: capUser)
                        capDatabase.add()
                    }
                    //Get the Current User ID Saved.
                    User.session.currentUserID = (authResult?.user.uid)!
                    
                    //Move to the HomeController
                    DispatchQueue.main.async {
                        User.session.isSignedIn = true
                        User.session.isAnonymous = true
                        self.nextController()
                    }
                }
                else {
                    self.handling(error)
                }
            }
            
            
        })
        self.present(requestAlert, animated: true)
    }
}
