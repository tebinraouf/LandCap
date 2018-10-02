//
//  CapUser.swift
//  LandCapApp
//
//  Created by Tebin on 9/20/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import Foundation

public class CapUser {
    public var Name : String!
    public var Key: String!
    public var isAnonymous: Bool!
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
