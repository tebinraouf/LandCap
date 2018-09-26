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

class HomeController: UIViewController {
    
    var previewView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.mainColor
        return view
    }()
    
    var takePhotoBtn: UIButton = {
        let btn = UIButton(type: UIButtonType.system)
        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.setTitle("Take", for: UIControlState.normal)
        btn.backgroundColor = UIColor.mainColor
        btn.tintColor = UIColor.textColor
        btn.layer.cornerRadius = 40
        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        btn.addTarget(self, action: #selector(handleTakePhoto), for: .touchDown)
        return btn
    }()
    var captureSession: AVCaptureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var photoOutput: AVCapturePhotoOutput?
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupView()
        
        print("HomeController")
        
        setupCamera()
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeToProfile(sender:)))
        swipe.direction = UISwipeGestureRecognizerDirection.left
        view.addGestureRecognizer(swipe)
    }
    
    
    func setupView() {
        view.addSubview(previewView)
        
        NSLayoutConstraint.activate([
            previewView.topAnchor.constraint(equalTo: view.topAnchor),
            previewView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            previewView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            previewView.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
        view.addSubview(takePhotoBtn)
        NSLayoutConstraint.activate([
            takePhotoBtn.bottomAnchor.constraint(equalTo: previewView.bottomAnchor, constant: -20),
            takePhotoBtn.centerXAnchor.constraint(equalTo: previewView.centerXAnchor),
            takePhotoBtn.widthAnchor.constraint(equalToConstant: 80),
            takePhotoBtn.heightAnchor.constraint(equalToConstant: 80)
            ])
        
    }
    @objc func handleTakePhoto() {
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: self)
    }
    
    
    func setupCamera() {
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        startRunningCaptureSession()
    }
    func setupCaptureSession() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        
    }
    func setupDevice() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        let devices = deviceDiscoverySession.devices
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            }
        }
    }
    func setupInputOutput() {
        do {
            guard let backCamera = backCamera else { return }
            let captureDeviceInput = try AVCaptureDeviceInput(device: backCamera)
            captureSession.addInput(captureDeviceInput)
            
            photoOutput = AVCapturePhotoOutput()
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
            captureSession.addOutput(photoOutput!)
        } catch {
            print(error)
        }
    }
    func setupPreviewLayer() {
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = view.bounds
        previewView.layer.addSublayer(cameraPreviewLayer!)
    }
    func startRunningCaptureSession() {
        captureSession.startRunning()
    }
}


extension HomeController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            let photoController = PhotoController()
            photoController.takenImage = UIImage(data: imageData)
            let navigationController = UINavigationController(rootViewController: photoController)
            present(navigationController, animated: true, completion: nil)
        }
    }
}

extension HomeController: UIGestureRecognizerDelegate {
    @objc func handleSwipeToProfile(sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            navigationController?.pushViewController(ProfileController(), animated: true)
        }
    }
}
