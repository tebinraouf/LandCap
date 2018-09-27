//
//  AVDelegate.swift
//  LandCapApp
//
//  Created by Tebin on 9/26/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import UIKit
import AVFoundation

extension HomeController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            //upload the photo to firebase
            let userID = User.session.currentUserID
            
            let database = CapDatabase(userID: userID)
            let ref = database.uploadImage(imageData: imageData)
            let url = database.getUrl(ref: ref)
            print(url)
            //After finish processing the photo, display the photo
            let photoController = PhotoController()
            photoController.takenImage = UIImage(data: imageData)
            let navigationController = UINavigationController(rootViewController: photoController)
            present(navigationController, animated: true, completion: nil)
            
            
            
        }
    }
}
