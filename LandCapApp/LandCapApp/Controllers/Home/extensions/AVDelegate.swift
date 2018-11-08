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
    ///AVCapturePhotoCaptureDelegate delegate function
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            //After finish processing the photo, display the photo
            process(imageData: imageData)
        }
    }
    ///Pass the taken photo to the next controller
    public func process(imageData: Data) {
        let photoController = PhotoController()
        photoController.homeController = self
        photoController.imageData = imageData
        let navigationController = UINavigationController(rootViewController: photoController)
        present(navigationController, animated: true, completion: nil)
    }
}
