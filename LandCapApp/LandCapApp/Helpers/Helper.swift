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
}

public func alert(title: String, message: String, viewController: UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
    viewController.present(alert, animated: true)
}

public var isLoggedIn: Bool {
    get {
        return UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
    set {
        UserDefaults.standard.setValue(newValue, forKey: "isLoggedIn")
        UserDefaults.standard.synchronize()
    }
}
