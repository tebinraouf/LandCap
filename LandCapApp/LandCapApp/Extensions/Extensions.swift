//
//  Extensions.swift
//  LandCapApp
//
//  Created by Tebin on 9/10/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    public class var mainColor: UIColor {
        return UIColor(r: 33, g: 147, b: 176, a: 1)
    }
    public class var secondaryColor: UIColor {
        return UIColor(r: 109, g: 213, b: 237, a: 1)
    }
    public class var textColor: UIColor {
        return .white
    }
    public class var blackColor: UIColor {
        return .black
    }
    public class var whiteColor: UIColor {
        return .white
    }
}
