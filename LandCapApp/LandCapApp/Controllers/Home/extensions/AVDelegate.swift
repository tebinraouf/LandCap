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
            //After finish processing the photo, display the photo
            let photoController = PhotoController()
            photoController.homeController = self
            photoController.imageData = imageData
            let navigationController = UINavigationController(rootViewController: photoController)
            present(navigationController, animated: true, completion: nil)
        }
    }
}
