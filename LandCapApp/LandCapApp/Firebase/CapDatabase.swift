//
//  CapDatabase.swift
//  LandCapApp
//
//  Created by Tebin on 9/20/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class CapDatabase {

    private var user: CapUser!
    private var ref: DatabaseReference!
    private var storageRef: StorageReference!
    
    private var userID: String!
    
    init() {
        //empty
    }
    //Create an instance of CapDatabase with userID and get/set user information
    init(userID: String) {
        self.userID = userID
    }
    init(user: CapUser) {
        ref = Database.database().reference()
        self.user = user
    }
    
    func add() {
        self.ref.child("users").child(user.Key).setValue(["name": user.Name])
    }
    
    func update(name: String) {
        self.ref.child("users/\(user.Key!)/name").setValue(name)
    }
    func uploadImage(imageData: Data) -> StorageReference {
        
        //get unique id for image
        User.session.tempID = UUID().uuidString
        //Upload the image
        storageRef = Storage.storage().reference()
        let photoRef = storageRef.child("users/temp//\(userID!)/\(User.session.tempID).jpeg")
        let photo = photoRef.putData(imageData, metadata: nil) { (metaData, error) in
            if error == nil {
                print("Correct...")
                print(metaData)
            }
            else {
                print(error)
            }
        }
        return photoRef
    }
    func getUrl(ref: StorageReference) -> String {
        //get the URL
        var returnUrl = ""
        ref.downloadURL { (url, error) in
            print(error)
            if let downloadUrl = url {
                print(downloadUrl)
                returnUrl = downloadUrl.absoluteString
            }
        }
        return returnUrl
    }
}
