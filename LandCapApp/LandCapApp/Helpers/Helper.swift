//
//  Helper.swift
//  LandCapApp
//
//  Created by Tebin on 9/16/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import Foundation
import UIKit

///A utility class for all cell IDs
class CellID {
    ///PageCell ID for `PageCell`
    static let PageCell = "PageCell"
    ///InfoCell ID for `InfoCell`
    static let InfoCell = "InfoCell"
    ///ProfileCell ID for `ProfileCell`
    static let ProfileCell = "ProfileCell"
}

public func alert(title: String, message: String, viewController: UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
    viewController.present(alert, animated: true)
}


///A utility class to represent a user in local storage for better UI
public class User {
    ///Singleton to handle current
    public static let session = User()
    
    ///Hold the status of the user
    public var isSignedIn: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isLoggedIn")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "isLoggedIn")
            UserDefaults.standard.synchronize()
        }
    }
    ///Hold the current user ID
    public var currentUserID: String {
        get {
            return UserDefaults.standard.string(forKey: "currentUserID") ?? "None"
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "currentUserID")
            UserDefaults.standard.synchronize()
        }
    }
    ///Hold the anonymous user ID
    public var anonymousUserID: String? {
        get {
            return UserDefaults.standard.string(forKey: "anonymousUserID")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "anonymousUserID")
            UserDefaults.standard.synchronize()
        }
    }
    ///Hold if the user is anonymous
    public var isAnonymous: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isAnonymous")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "isAnonymous")
            UserDefaults.standard.synchronize()
        }
    }
}
