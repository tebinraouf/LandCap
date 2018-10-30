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
                    alert(title: App.label.emailTitle, message: App.label.emailMessage, viewController: self)
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
                    user.Name = name
                    user.setAuthorizedUser()
                    //fill database with initial values
                    let capDatabase = CapDatabase(user: user)
                    capDatabase.register()
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
                            alert(title: App.label.accountCreated, message: App.label.emailMessage, viewController: self)
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
        let requestAlert = UIAlertController(title: App.label.requestPassword, message: nil, preferredStyle: .alert)
        requestAlert.addTextField { (textfield) in
            textfield.keyboardType = .emailAddress
            textfield.placeholder = App.label.emailPlaceHolder
        }
        requestAlert.addAction(UIAlertAction(title: App.label.requestPasswordCancel, style: .cancel, handler: nil))
        requestAlert.addAction(UIAlertAction(title: App.label.requestNewPassword, style: .default) { (action) in
            guard let requestedEmail = requestAlert.textFields?.first?.text else { return }
            Auth.auth().sendPasswordReset(withEmail: requestedEmail) { (error) in
                self.handling(error)
                alert(title: App.label.requestSentTitle, message: App.label.requestSentMessage, viewController: self)
            }
        })
        self.present(requestAlert, animated: true)
    }
    
    func skipBtn() {
        let requestAlert = UIAlertController(title: App.label.skipTitle, message: App.label.skipMessage, preferredStyle: .alert)
        requestAlert.addAction(UIAlertAction(title: App.label.skipCancel, style: .cancel, handler: nil))
        requestAlert.addAction(UIAlertAction(title: App.label.skipOkay, style: .default) { (action) in
            
            Auth.auth().signInAnonymously() { (authResult, error) in
                if error == nil {
                    if let authResult = authResult {
                        let user = authResult.user
                        let uid = user.uid
                        //set the initial user details for database
                        let capUser = CapUser()
                        capUser.Key = uid
                        capUser.setAnonymousUser()
                        //fill database with initial values
                        let capDatabase = CapDatabase(user: capUser)
                        capDatabase.createAnnonymous()
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
