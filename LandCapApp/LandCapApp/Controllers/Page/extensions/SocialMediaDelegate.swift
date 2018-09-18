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
        print("loginButton")
        
        
        
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)

        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                self.handling(error)
                return
            }
            let current = Auth.auth().currentUser
            print(current?.email)
            print(current?.displayName)
            
        }

       
        
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("loginButtonDidLogOut")
    }
    
    
}
