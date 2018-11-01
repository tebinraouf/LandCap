//
//  HomeViewDelegate.swift
//  LandCapApp
//
//  Created by Tebin on 9/26/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit
import Firebase

extension HomeController: HomeViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func handleMoreButton() {
        print("more more more...")
//        try? Auth.auth().signOut()
        User.session.isSignedIn = false
        let navigationController = UINavigationController(rootViewController: PageController())
        present(navigationController, animated: true, completion: nil)
    }
    func handleTakingPhoto() {
        let settings = AVCapturePhotoSettings()
        captureCamera.photoOutput?.capturePhoto(with: settings, delegate: self)
    }
    func handleUploadingPhoto() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary //UIImagePickerController.SourceType.
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true)
        let chosenImage = info[UIImagePickerControllerEditedImage] as? UIImage
        guard let image = chosenImage else { return }
        guard let imageData = UIImagePNGRepresentation(image) else { return }
        process(imageData: imageData)
    }
}
