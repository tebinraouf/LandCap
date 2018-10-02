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
        self.ref.child("users").child(user.Key).setValue(["name": user.Name, "isAnonymous": user.isAnonymous, "photoLimit": user.photoLimit])
    }
    
    func update(name: String) {
        self.ref.child("users/\(user.Key!)/name").setValue(name)
    }
    //Accepts an image data to be uploaded and return its URL
    func uploadImage(imageData: Data, success: @escaping (_ url:String)->()) {
        
        let imageID = uniqueImageName()
        
        //Upload the image
        storageRef = Storage.storage().reference()
        let photoRef = storageRef.child("users").child("temp").child(userID!).child("\(imageID).jpeg")
        //Set Image Metadata
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        //Upload Image to Firebase
        let photo = photoRef.putData(imageData, metadata: metaData) { (metaData, error) in
            if error == nil {
//                print(metaData)
            }
            else {
//                print(error)
            }
        }
        photo.resume()
        
        photo.observe(StorageTaskStatus.success) { (snap) in
            snap.reference.downloadURL { (url, error) in
                if let downloadUrl = url {
                    success(downloadUrl.absoluteString)
                }
            }
        }
    }
    private func uniqueImageName() -> String {
        //get unique id for image
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        return formatter.string(from: currentDateTime)
    }
}
