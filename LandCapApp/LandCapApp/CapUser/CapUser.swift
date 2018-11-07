//
//  CapUser.swift
//  LandCapApp
//
//  Created by Tebin on 9/20/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import Foundation
///A class to represent LandCap's user
public class CapUser {
    ///User name
    public var Name : String!
    ///User key
    public var Key: String!
    ///User status
    public var isAnonymous: Bool!
    ///User photo limit to analyze photos
    public var photoLimit: Int!
    
    
    
    /// Initial Value for Authorized User.
    /// - Photo Limit: 100
    /// - isAnonymous: false
    public func setAuthorizedUser() {
        photoLimit = 100
        isAnonymous = false
    }
    /// Initial Value for Anonymous User
    /// - Photo Limit: 10
    /// - isAnonymous: true
    /// - Name: Guest
    public func setAnonymousUser() {
        photoLimit = 10
        isAnonymous = true
        Name = "Guest"
    }
}
