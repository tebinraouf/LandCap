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
    public class var appColor: UIColor {
        return UIColor(r: 255, g: 56, b: 63, a: 1)
    }
    public class var appGray: UIColor {
        return UIColor(r: 247, g: 247, b: 247, a: 1)
    }
    public class var appRedish: UIColor {
        return UIColor(r: 255, g: 56, b: 63, a: 1)
    }
    public class var appLightGreen: UIColor {
        return UIColor(r: 220, g: 226, b: 202, a: 1)
    }
    
}
