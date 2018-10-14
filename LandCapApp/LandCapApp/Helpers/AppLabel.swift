//
//  AppLabel.swift
//  LandCapApp
//
//  Created by Tebin on 10/12/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import Foundation

public class App {
    ///Singleton to handle all labels in App
    public static let label = App()
    
    //App Name
    public var appName: String {
        return NSLocalizedString("LandCap", comment: "The name of the app")
    }
    //On Boarding Page
    public var getStartedButton: String {
        return NSLocalizedString("Get Started", comment: "skip to login view")
    }
    public var signIn: String {
        return NSLocalizedString("Sign In", comment: "Sign in to your account")
    }
    public var signUp: String {
        return NSLocalizedString("Sign Up", comment: "Register to save your info in the cloud")
    }
    public var enterName: String {
        return NSLocalizedString("enter name", comment: "enter your name here")
    }
    public var enterEmail: String {
        return NSLocalizedString("enter email address", comment: "enter your email address")
    }
    public var enterPassword: String {
        return NSLocalizedString("enter password", comment: "enter your password")
    }
    public var forgetPassword: String {
        return NSLocalizedString("Forget Password", comment: "Forget the password label")
    }
    
    public var email: String {
        return NSLocalizedString("Email", comment: "Email")
    }
    public var password: String {
        return NSLocalizedString("Password", comment: "Password")
    }
    public var internalError: String {
        return NSLocalizedString("Internal Error", comment: "Internal Error")
    }
    public var oops: String {
        return NSLocalizedString("Oops", comment: "Something went wring")
    }
    public var emailTitle: String {
        return NSLocalizedString("Email Verification", comment: "Email Verification")
    }
    public var emailMessage: String {
        return NSLocalizedString("Email Ver Message", comment: "Verify your account")
    }
    public var accountCreated: String {
        return NSLocalizedString("Account Created", comment: "Email Verification")
    }
    public var requestPassword: String {
        return NSLocalizedString("Request Password", comment: "Request New Password")
    }
    public var requestNewPassword: String {
        return NSLocalizedString("Request New Password", comment: "Request New Password")
    }
    public var requestPasswordCancel: String {
        return NSLocalizedString("Request Cancel", comment: "Cancel Requesting Password")
    }
    public var requestSentTitle: String {
        return NSLocalizedString("Request Sent", comment: "Request Sent Title")
    }
    public var requestSentMessage: String {
        return NSLocalizedString("Request Message", comment: "Request Sent Message")
    }
    public var emailPlaceHolder: String {
        return NSLocalizedString("Email Placeholder", comment: "Email placeholder")
    }
    public var skipButton: String {
        return NSLocalizedString("Skip", comment: "skip sign in")
    }
    public var skipTitle: String {
        return NSLocalizedString("Skip Title", comment: "Skip Title goes here")
    }
    public var skipMessage: String {
        return NSLocalizedString("Skip Message", comment: "Skip message goes here")
    }
    public var skipCancel: String {
        return NSLocalizedString("Skip Cancel", comment: "Skip cancel goes here")
    }
    public var skipOkay: String {
        return NSLocalizedString("Skip Okay", comment: "Skip okay goes here")
    }
    
    //PhotoController
    public var cancelPhoto: String {
        return NSLocalizedString("Cancel Photo", comment: "Cancel the taken photo. Take another.")
    }
    public var processPhoto: String {
        return NSLocalizedString("Process Photo", comment: "Process the taken photo.")
    }
    public var notDetectedTitle: String {
        return NSLocalizedString("Not Detected Title", comment: "The taken photo is not detected")
    }
    public var notDetectedMessage: String {
        return NSLocalizedString("Not Detected Message", comment: "The taken photo is not detected. Try again.")
    }
    public var visionError: String {
        return NSLocalizedString("Vision Error", comment: "Google Vision Error")
    }
    
    //InfoController
    public var cancelInfo: String {
        return NSLocalizedString("Cancel Info", comment: "Cancel InfoController and take more pictures")
    }
    public var saveInfo: String {
        return NSLocalizedString("Save Info", comment: "Save InfoController")
    }
    public var wikiAlertTitle: String {
        return NSLocalizedString("Wiki Alert Title", comment: "Indicate how many texts can be selected")
    }
    public var wikiAlertMessage: String {
        return NSLocalizedString("Wiki Alert Message", comment: "Indicate how many texts can be selected")
    }
}
