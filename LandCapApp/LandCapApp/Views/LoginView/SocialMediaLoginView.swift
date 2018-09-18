//
//  SocialMedia.swift
//  LandCapApp
//
//  Created by Tebin on 9/17/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import UIKit
import FBSDKLoginKit


class SocialMediaLoginView: BaseView {
    var socialMediaDelegate: SocialMediaLoginDelegate!
    var facebookBtn: FBSDKLoginButton = {
        let fb = FBSDKLoginButton()
        fb.translatesAutoresizingMaskIntoConstraints = false
        return fb
    }()
    override func setupView() {
        super.setupView()
        translatesAutoresizingMaskIntoConstraints = false
        setupImageView()
        facebookBtn.delegate = self
    }
    func setupImageView() {
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
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        socialMediaDelegate.loginButton(loginButton, didCompleteWith: result, error: error)
    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        socialMediaDelegate.loginButtonDidLogOut(loginButton)
    }
}
protocol SocialMediaLoginDelegate {
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!)
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!)
}
