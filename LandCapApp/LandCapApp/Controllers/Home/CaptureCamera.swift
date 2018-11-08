//
//  CameraCapture.swift
//  LandCapApp
//
//  Created by Tebin on 9/26/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import AVFoundation

///A Utility class to create a custom camera
class CaptureCamera {
    
    private var captureSession: AVCaptureSession = AVCaptureSession()
    private var backCamera: AVCaptureDevice?
    
    ///AVCapturePhotoOutput instance of the photo
    public var photoOutput: AVCapturePhotoOutput?
    private var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    private var homeView: HomeView
    private var frame: CGRect
    ///Initialize a camera
    /// - Parameter homeView: a `HomeView` instance to display the camera
    ///
    init(_ homeView: HomeView, _ frame: CGRect) {
        self.homeView = homeView
        self.frame = frame
    }
    ///Setup the camera
    public func setupCamera() {
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        startRunningCaptureSession()
    }
    private func setupCaptureSession() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    private func setupDevice() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        let devices = deviceDiscoverySession.devices
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            }
        }
    }
    private func setupInputOutput() {
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
    private func setupPreviewLayer() {
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = frame
        homeView.previewView.layer.addSublayer(cameraPreviewLayer!)
    }
    private func startRunningCaptureSession() {
        captureSession.startRunning()
    }
}
