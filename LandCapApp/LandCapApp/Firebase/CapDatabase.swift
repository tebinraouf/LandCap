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

///A utility class to make Firebase communication and actions easy
class CapDatabase {

    ///The current user
    private var user: CapUser!
    
    ///A database reference for interacting with the database
    private var ref: DatabaseReference!
    
    ///A storage reference for uploading photos
    private var storageRef: StorageReference!
    
    ///The current userID
    private var userID: String!
    
    ///Empty init
    init() {
        //empty
    }
    ///Create an instance of CapDatabase with userID and get/set user information
    /// - Parameter userID: unique user ID
    ///
    init(userID: String) {
        ref = Database.database().reference()
        self.userID = userID
    }
    ///Create an instance of CapDatabase with a `CapUser` instance
    /// - Parameter user: a CapUser user
    ///
    init(user: CapUser) {
        ref = Database.database().reference()
        self.user = user
    }
    ///Setup the initial user and user limit
    ///
    /// - Returns: Void
    func setupUser() {
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
    ///Update the user's photo limit
    /// - Parameter callback: a callback function to return the current photoLimit
    ///
    /// - Returns: Void
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
    ///Update/Replace the user's name
    /// - Parameter name: the name to be updated/replaced
    ///
    /// - Returns: Void
    func update(name: String) {
        self.ref.child("users/\(user.Key!)/name").setValue(name)
    }
    ///Accepts an image data to be uploaded and return its URL
    /// - Parameter imageData: the image data to be uploaded
    /// - Parameter success: a callback function with url
    ///
    /// - Returns: Void
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
    /// A utility function to generate a unique name for images
    ///
    /// - Returns: the unique name
    private func uniqueImageName() -> String {
        //get unique id for image
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        return formatter.string(from: currentDateTime)
    }
    ///Add a new image with text and name to Firebase
    /// - Parameter data: the image data to be uploaded
    /// - Parameter text: the text of the image (landmark text taken from WikiPedia).
    /// - Parameter name: the name of the image (landmark name)
    /// - Parameter callback: a callback for UI.
    ///
    /// - Returns: Void
    func addNew(image data: Data, with text: String, with name: String, callback: @escaping ()->()) {
        uploadImage(imageData: data) { (urlString) in
            let newRef = self.ref.child("users").child(self.userID!).child("images").childByAutoId()
            newRef.setValue(["link": urlString, "text": text, "name": name])
            callback()
        }
    }
    ///Get all user images from the database
    /// - Parameter callback: a callback function that returns the `UserImage` object for presentation
    ///
    /// - Returns: Void
    func getImages(_ callback: @escaping (UserImage)->()) {
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
    ///Delete image from the database
    /// - Parameter userImage: the `UserImage` object to be deleted
    ///
    /// - Returns: Void
    func deleteUserImage(userImage: UserImage) {
        if let id = userImage.id {
            ref.child("users").child(userID).child("images").child(id).removeValue()
        }
    }
}
