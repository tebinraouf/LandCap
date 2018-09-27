//
//  SocialMediaDelegate.swift
//  LandCapApp
//
//  Created by Tebin on 9/17/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import Foundation
import FBSDKLoginKit
import FirebaseAuth

extension PageController: SocialMediaLoginDelegate {
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {

        if FBSDKAccessToken.currentAccessTokenIsActive() {
            let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            
            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                if let error = error {
                    self.handling(error)
                    User.session.isSignedIn = false
                }
                if let authResult = authResult {
                    
                    //set the initial user details for database
                    let user = CapUser()
                    user.Key = authResult.user.uid
                    user.Name = authResult.user.displayName
                    
                    //fill database with initial values
                    let capDatabase = CapDatabase(user: user)
                    capDatabase.add()

                    DispatchQueue.main.async {
                        User.session.isSignedIn = true
                        self.nextController()
                    }
                }
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("loginButtonDidLogOut")
    }
    
    
}
