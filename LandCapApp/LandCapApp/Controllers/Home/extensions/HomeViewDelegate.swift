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

extension HomeController: HomeViewDelegate {
    func handleMoreButton() {
        print("more more more...")
        User.session.isSignedIn = false
        let navigationController = UINavigationController(rootViewController: PageController())
        present(navigationController, animated: true, completion: nil)
    }
    
    func handleTakingPhoto() {
        let settings = AVCapturePhotoSettings()
        captureCamera.photoOutput?.capturePhoto(with: settings, delegate: self)
    }
}
