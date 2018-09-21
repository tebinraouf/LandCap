//
//  CapDatabase.swift
//  LandCapApp
//
//  Created by Tebin on 9/20/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import Foundation
import FirebaseDatabase

class CapDatabase {
    
    private var user: CapUser!
    private var ref: DatabaseReference!
    
    init() {
        //empty
    }
    init(user: CapUser) {
        ref = Database.database().reference()
        self.user = user
    }
    
    func add() {
        self.ref.child("users").child(user.Key).setValue(["name": user.Name])
    }
    
    func update(name: String) {
        self.ref.child("users/\(user.Key)/name").setValue(name)
    }
    
}
