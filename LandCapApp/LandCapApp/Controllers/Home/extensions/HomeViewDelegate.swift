//
//  HomeViewDelegate.swift
//  LandCapApp
//
//  Created by Tebin on 9/26/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import Foundation
import AVFoundation

extension HomeController: HomeViewDelegate {
    func handleTakingPhoto() {
        let settings = AVCapturePhotoSettings()
        captureCamera.photoOutput?.capturePhoto(with: settings, delegate: self)
    }
}
