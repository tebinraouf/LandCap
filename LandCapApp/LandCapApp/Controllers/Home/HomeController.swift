//
//  HomeController.swift
//  LandCapApp
//
//  Created by Tebin on 9/16/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import CDAlertView

///The main controller after the user is signed in
class HomeController: UIViewController {
    ///The HomeController view
    public var homeView: HomeView = HomeView()
    ///`CaptureCamera` instance
    public var captureCamera: CaptureCamera!
    
    ///Initial Controller load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //setup the view
        setupView()
        setupDelegate()
        
        //configure and setup the camera
        captureCamera = CaptureCamera(homeView, view.frame)
        captureCamera.setupCamera()
        
        //Configure Swiping
        handleSwipeGestureRecognizer()
        
        //check camera permission
        let _ = CameraAccessHandler()
    }
    ///viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    private func setupDelegate() {
        homeView.delegate = self
    }
    private func setupView() {
        view.addSubview(homeView)
        NSLayoutConstraint.activate([
            homeView.topAnchor.constraint(equalTo: view.topAnchor),
            homeView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            homeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeView.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
    }
    private func handleSwipeGestureRecognizer() {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeToProfile(sender:)))
        swipe.direction = UISwipeGestureRecognizerDirection.left
        view.addGestureRecognizer(swipe)
    }
    
    
}

///A utility class to handle Camera Access
public class CameraAccessHandler {
    init() {
        checkCameraAccess()
    }
    private func checkCameraAccess() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .denied:
            print("Denied, request permission from settings")
            presentCameraSettings()
        case .restricted:
            print("Restricted, device owner must approve")
        case .authorized:
            print("Authorized, proceed")
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { success in
                if success {
                    print("Permission granted, proceed")
                } else {
                    print("Permission denied")
                }
            }
        }
    }
    private func presentCameraSettings() {
        let alert = CDAlertView(title: App.label.homeAlertCameraAccessTitle, message: App.label.homeAlertCameraAccessBody, type: .warning)
        let cancel = CDAlertViewAction(title: App.label.homeAlertCameraAccessCancelBtn, font: nil, textColor: .mainColor, backgroundColor: nil, handler: nil)
        let settingButton = CDAlertViewAction(title: App.label.homeAlertCameraAccessSettingBtn, font: nil, textColor: .mainColor, backgroundColor: nil, handler: { (action) -> Bool in
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: { _ in
                    // Handle
                })
            }
            return true
        })
        alert.add(action: cancel)
        alert.add(action: settingButton)
        alert.show()
    }
}


