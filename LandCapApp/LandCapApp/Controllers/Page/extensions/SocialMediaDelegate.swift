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

    ///FBSDKLoginKit login delegate
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {

        if FBSDKAccessToken.currentAccessTokenIsActive() {
            let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)

            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                if error == nil {
                    //Store the user's name in the database
                    if let authResult = authResult {
                        //set the initial user details for database
                        let user = CapUser()
                        user.Key = authResult.user.uid
                        user.Name = authResult.user.displayName
                        user.setAuthorizedUser()
                        User.session.currentUserID = authResult.user.uid
                        User.session.isAnonymous = false
                        //fill database with initial values
                        let capDatabase = CapDatabase(user: user)
                        capDatabase.setupUser()
                    }
                    DispatchQueue.main.async {
                        User.session.isSignedIn = true
                        self.nextController()
                    }
                } else {
                    self.handling(error)
                }
            }
        }
    }
    ///FBSDKLoginKit logout delegate
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("loginButtonDidLogOut")
    }
    
    
}
