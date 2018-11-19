//
//  AppLabel.swift
//  LandCapApp
//
//  Created by Tebin on 10/12/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import Foundation
///A utility class to handle all localized labels
public class App {
    ///Singleton to handle all labels in App
    public static let label = App()
    
    ///App Name
    public var appName: String {
        return NSLocalizedString("LandCap", comment: "The name of the app")
    }
    ///On Boarding Page
    public var getStartedButton: String {
        return NSLocalizedString("Get Started", comment: "skip to login view")
    }
    ///Sign In Label
    public var signIn: String {
        return NSLocalizedString("Sign In", comment: "Sign in to your account")
    }
    ///Sign Up Label
    public var signUp: String {
        return NSLocalizedString("Sign Up", comment: "Register to save your info in the cloud")
    }
    ///Enter Name Label
    public var enterName: String {
        return NSLocalizedString("enter name", comment: "enter your name here")
    }
    ///Enter Email label
    public var enterEmail: String {
        return NSLocalizedString("enter email address", comment: "enter your email address")
    }
    ///Enter password label
    public var enterPassword: String {
        return NSLocalizedString("enter password", comment: "enter your password")
    }
    ///Forgot Password label
    public var forgotPassword: String {
        return NSLocalizedString("Forgot Password", comment: "Forget the password label")
    }
    ///Email label
    public var email: String {
        return NSLocalizedString("Email", comment: "Email")
    }
    ///Password label
    public var password: String {
        return NSLocalizedString("Password", comment: "Password")
    }
    ///Internal error label
    public var internalError: String {
        return NSLocalizedString("Internal Error", comment: "Internal Error")
    }
    ///Something went wrong label
    public var oops: String {
        return NSLocalizedString("Oops", comment: "Something went wring")
    }
    ///Email verification label
    public var emailTitle: String {
        return NSLocalizedString("Email Verification", comment: "Email Verification")
    }
    ///Email verification message label
    public var emailMessage: String {
        return NSLocalizedString("Email Ver Message", comment: "Verify your account")
    }
    ///Account created label
    public var accountCreated: String {
        return NSLocalizedString("Account Created", comment: "Email Verification")
    }
    ///Request password label
    public var requestPassword: String {
        return NSLocalizedString("Request Password", comment: "Request New Password")
    }
    ///Request new password label
    public var requestNewPassword: String {
        return NSLocalizedString("Request New Password", comment: "Request New Password")
    }
    ///Cancel request password label
    public var requestPasswordCancel: String {
        return NSLocalizedString("Request Cancel", comment: "Cancel Requesting Password")
    }
    ///Request sent label
    public var requestSentTitle: String {
        return NSLocalizedString("Request Sent", comment: "Request Sent Title")
    }
    ///Request sent message label
    public var requestSentMessage: String {
        return NSLocalizedString("Request Message", comment: "Request Sent Message")
    }
    ///Email placeholder label
    public var emailPlaceHolder: String {
        return NSLocalizedString("Email Placeholder", comment: "Email placeholder")
    }
    ///Skip button label
    public var skipButton: String {
        return NSLocalizedString("Skip", comment: "skip sign in")
    }
    ///Skip alert title label
    public var skipTitle: String {
        return NSLocalizedString("Skip Title", comment: "Skip Title goes here")
    }
    ///Skip alert message label
    public var skipMessage: String {
        return NSLocalizedString("Skip Message", comment: "Skip message goes here")
    }
    ///Skip alert cancel label
    public var skipCancel: String {
        return NSLocalizedString("Skip Cancel", comment: "Skip cancel goes here")
    }
    ///Skip alert okay label
    public var skipOkay: String {
        return NSLocalizedString("Skip Okay", comment: "Skip okay goes here")
    }
    
    //HomeController
    ///Alert for anonymous user title label
    public var homeAlertTitle: String {
        return NSLocalizedString("Profile Oops", comment: "Label to indicate profile is not available")
    }
    ///Alert for anonymous user message label
    public var homeAlertMessage: String {
        return NSLocalizedString("Profile Not Available", comment: "Message to indicate profile is not available")
    }
    ///Camera Access Title Label
    public var homeAlertCameraAccessTitle: String {
        return NSLocalizedString("Camera Access Title", comment: "Camera access title label")
    }
    ///Camera Access Message Label
    public var homeAlertCameraAccessBody: String {
        return NSLocalizedString("Camera Access Body", comment: "Camera access message (body) label")
    }
    ///Camera Access Setting Button Label
    public var homeAlertCameraAccessSettingBtn: String {
        return NSLocalizedString("Camera Access Settings Btn", comment: "Camera access settings button label")
    }
    ///Camera Access Cancel Button Label
    public var homeAlertCameraAccessCancelBtn: String {
        return NSLocalizedString("Camera Access Cancel Btn", comment: "Camera access cancel button label")
    }
    ///Camera Access Label
    public var homeLabelCameraAccess: String {
        return NSLocalizedString("Camera Access Label", comment: "Camera access label")
    }
    
    //PhotoController
    ///Cancel taken photo label
    public var cancelPhoto: String {
        return NSLocalizedString("Cancel Photo", comment: "Cancel the taken photo. Take another.")
    }
    ///Process taken photo label
    public var processPhoto: String {
        return NSLocalizedString("Process Photo", comment: "Process the taken photo.")
    }
    ///Photo not detected title label
    public var notDetectedTitle: String {
        return NSLocalizedString("Not Detected Title", comment: "The taken photo is not detected")
    }
    ///Photo not detected message label
    public var notDetectedMessage: String {
        return NSLocalizedString("Not Detected Message", comment: "The taken photo is not detected. Try again.")
    }
    ///Google vision error label
    public var visionError: String {
        return NSLocalizedString("Vision Error", comment: "Google Vision Error")
    }
    //PhotoLimit
    ///Photo limit title label
    public var photoLimitTitle: String {
        return NSLocalizedString("Limit Error Title", comment: "Label to indicate photo limit")
    }
    ///Photo limit message label
    public var photoLimitMessage: String {
        return NSLocalizedString("Limit Error Message", comment: "Message to indicate photo limit for authorized user")
    }
    ///Photo limit anonymous message label
    public var photoLimitAnnonymousMessage: String {
        return NSLocalizedString("Limit Error Message Annonymous", comment: "Message to indicate photo limit for annonymous user")
    }
    //InfoController
    ///Cancel `InfoController` label
    public var cancelInfo: String {
        return NSLocalizedString("Cancel Info", comment: "Cancel InfoController and take more pictures")
    }
    ///Save Info label
    public var saveInfo: String {
        return NSLocalizedString("Save Info", comment: "Save InfoController")
    }
    ///Wiki alert title label
    public var wikiAlertTitle: String {
        return NSLocalizedString("Wiki Alert Title", comment: "Indicate how many texts can be selected")
    }
    ///Wiki alert message label
    public var wikiAlertMessage: String {
        return NSLocalizedString("Wiki Alert Message", comment: "Indicate how many texts can be selected")
    }
    ///Wiki firebase alert title label
    public var wikiFirebaseAlertTitle: String {
        return NSLocalizedString("Wiki Firebase Title", comment: "Title to indicate artifact is uploaded")
    }
    ///Wiki firebase alert message label
    public var wikiFirebaseAlertMessage: String {
        return NSLocalizedString("Wiki Firebase Message", comment: "Message to indicate artifact is uploaded")
    }
    ///Wiki alert button to go back to profile label
    public var wikiFirebaseAlertProfileBtn: String {
        return NSLocalizedString("Wiki Button Profile", comment: "Button to go to profile")
    }
    ///Wiki alert button to go back to home label
    public var wikiFirebaseAlertHomeBtn: String {
        return NSLocalizedString("Wiki Button Home", comment: "Button to go back to home")
    }
    ///Label to indicate save is not available for guest user
    public var wikiSaveGuestTitle: String {
        return NSLocalizedString("Wiki Save Guest Title", comment: "Label to indicate save is not available for guest user")
    }
    ///Message to indicate save is not available for guest use
    public var wikiSaveGuestMessage: String {
        return NSLocalizedString("Wiki Save Guest Message", comment: "Message to indicate save is not available for guest user")
    }
    
    
    
    //DetailsController
    ///Delete photo title label
    public var detailsAlertTitle: String {
        return NSLocalizedString("Delete Photo Title", comment: "A friendly title to show the user")
    }
    ///Cancel photo delete label
    public var detailsAlertCancelBtn: String {
        return NSLocalizedString("Cancel Photo Delete", comment: "Cancel and do nothing")
    }
    ///Accept photo delete label
    public var detailsAlertAcceptBtn: String {
        return NSLocalizedString("Accept Photo Delete", comment: "Accept and delete the photo")
    }
    ///Delete photo message label
    public var detailsAlertMessage: String {
        return NSLocalizedString("Photo Delete Body", comment: "User message to delete photo")
    }
    
}
