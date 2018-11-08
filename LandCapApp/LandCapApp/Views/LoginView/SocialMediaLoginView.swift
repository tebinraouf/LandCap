//
//  SocialMedia.swift
//  LandCapApp
//
//  Created by Tebin on 9/17/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import UIKit
import FBSDKLoginKit

///LoginView SocialMediaLoginView for third party login. Utility.
class SocialMediaLoginView: BaseView {
    
    ///SocialMediaLoginDelegate instance
    var socialMediaDelegate: SocialMediaLoginDelegate!
    
    private var facebookBtn: FBSDKLoginButton = {
        let fb = FBSDKLoginButton()
        fb.readPermissions = ["email"]
        fb.translatesAutoresizingMaskIntoConstraints = false
        return fb
    }()
    
    //Initial setup
    override func setupView() {
        super.setupView()
        translatesAutoresizingMaskIntoConstraints = false
        setupImageView()
        facebookBtn.delegate = self
    }
    private func setupImageView() {
        addSubview(facebookBtn)
        NSLayoutConstraint.activate([
            facebookBtn.topAnchor.constraint(equalTo: topAnchor),
            facebookBtn.leadingAnchor.constraint(equalTo: leadingAnchor),
            facebookBtn.trailingAnchor.constraint(equalTo: trailingAnchor),
            facebookBtn.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
}

extension SocialMediaLoginView: FBSDKLoginButtonDelegate {
    ///FBSDKLoginButton login
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        socialMediaDelegate.loginButton(loginButton, didCompleteWith: result, error: error)
    }
    ///FBSDKLoginButton logout
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        socialMediaDelegate.loginButtonDidLogOut(loginButton)
    }
}
///SocialMediaLoginDelegate delegate
protocol SocialMediaLoginDelegate {
    ///FBSDKLoginButton login
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!)
    ///FBSDKLoginButton logout
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!)
}
