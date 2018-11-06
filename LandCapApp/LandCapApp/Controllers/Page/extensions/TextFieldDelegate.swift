//
//  TextFieldDelegate.swift
//  LandCapApp
//
//  Created by Tebin on 9/16/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import Foundation
import UIKit

extension PageController: UITextFieldDelegate {
    //MARK: Handle Keyboard Dismissal
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        pageView.keyboardResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pageView.keyboardResponder()
        return true
    }
}