//
//  Helper.swift
//  LandCapApp
//
//  Created by Tebin on 9/16/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import Foundation
import UIKit

class CellID {
    static let PageCell = "PageCell"
    static let InfoCell = "InfoCell"
    static let ProfileCell = "ProfileCell"
}

public func alert(title: String, message: String, viewController: UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
    viewController.present(alert, animated: true)
}



public class User {
    //singleton to handle current
    public static let session = User()
    
    public var isSignedIn: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isLoggedIn")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "isLoggedIn")
            UserDefaults.standard.synchronize()
        }
    }
    public var currentUserID: String {
        get {
            return UserDefaults.standard.string(forKey: "currentUserID") ?? "None"
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "currentUserID")
            UserDefaults.standard.synchronize()
        }
    }
    public var anonymousUserID: String? {
        get {
            return UserDefaults.standard.string(forKey: "anonymousUserID")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "anonymousUserID")
            UserDefaults.standard.synchronize()
        }
    }
    
    
    public var isAnonymous: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isAnonymous")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "isAnonymous")
            UserDefaults.standard.synchronize()
        }
    }
    public var imageURL: String {
        get {
            return UserDefaults.standard.string(forKey: "imageURL") ?? "None"
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "imageURL")
            UserDefaults.standard.synchronize()
        }
    }
}
