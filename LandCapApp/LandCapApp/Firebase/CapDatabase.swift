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
        ref = Database.database().reference()
        self.userID = userID
    }
    init(user: CapUser) {
        ref = Database.database().reference()
        self.user = user
    }
    func login() {
        
    }
    func register() {
        
    }
    func annonymous() {
        self.ref.child("users").child(user.Key).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            if value == nil {
                //first time the user is anonymous
                self.ref.child("users").child(self.user.Key).setValue(["name": self.user.Name, "isAnonymous": self.user.isAnonymous, "photoLimit": self.user.photoLimit])
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    func photoLimit(callback: @escaping (Int)->()) {
        self.ref.child("users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            if value != nil {
                let limitCount = value!["photoLimit"] as! Int
                if limitCount > 0 {
                    self.ref.child("users").child(self.userID).child("photoLimit").setValue(limitCount-1)
                }
                callback(limitCount)
            }
        })
    }
    
    func update(name: String) {
        self.ref.child("users/\(user.Key!)/name").setValue(name)
    }
    //Accepts an image data to be uploaded and return its URL
    func uploadImage(imageData: Data, success: @escaping (_ url:String)->()) {
        
        let imageID = uniqueImageName()
        
        //Upload the image
        storageRef = Storage.storage().reference()
        let photoRef = storageRef.child("users").child(userID!).child("\(imageID).png")
        //Set Image Metadata
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
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
    public func addNew(image data: Data, with text: String, with name: String, callback: @escaping ()->()) {
        uploadImage(imageData: data) { (urlString) in
            let newRef = self.ref.child("users").child(self.userID!).child("images").childByAutoId()
            newRef.setValue(["link": urlString, "text": text, "name": name])
            callback()
        }
    }
    public func getImages(_ callback: @escaping (UserImage)->()) {
        storageRef = Storage.storage().reference()
        let newRef = self.ref.child("users").child(self.userID!).child("images")
        newRef.observe(DataEventType.childAdded) { (snapshot) in
            let imageObject = snapshot.value as? [String: AnyObject]
            var userImage = UserImage()
            if let imageObject = imageObject {
                if let text = imageObject["text"] as? String {
                    userImage.text = text
                }
                if let imageURL = imageObject["link"] as? String {
                    userImage.imageURL = imageURL
                }
                if let imageName = imageObject["name"] as? String {
                    userImage.name = imageName
                }
                userImage.id = snapshot.key
                callback(userImage)
            }
        }
    }
    public func deleteUserImage(userImage: UserImage) {
        if let id = userImage.id {
            ref.child("users").child(userID).child("images").child(id).removeValue()
        }
    }
}
