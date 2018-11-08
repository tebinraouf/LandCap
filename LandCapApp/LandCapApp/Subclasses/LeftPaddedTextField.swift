//
//  LeftPaddedTextField.swift
//  LandCapApp
//
//  Created by Tebin on 9/16/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import UIKit

///Custom padded UITextField
class LeftPaddedTextField: UITextField {
    ///textRect
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
    ///editingRect
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
}
