//
//  Home.swift
//  LandCapApp
//
//  Created by Tebin on 9/25/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

///The HomeController View
class HomeView: BaseView {
    
    ///The main view to hold the camera
    public var previewView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.mainColor
        return view
    }()
    ///The HomeViewDelegate instance to handle `HomeView` actions
    public var delegate: HomeViewDelegate!
    
    private var logoutBtn: UIButton = {
        let btn = UIButton(type: UIButtonType.system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = UIFont.icon(from: .fontAwesome, ofSize: 25)
        btn.setTitle(String.fontAwesomeIcon("signout"), for: UIControlState.normal)
        btn.tintColor = UIColor.textColor
        btn.addTarget(self, action: #selector(handleMoreButton), for: .touchDown)
        return btn
    }()
    private var profileBtn: UIButton = {
        let btn = UIButton(type: UIButtonType.system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = UIFont.icon(from: .fontAwesome, ofSize: 25)
        btn.setTitle(String.fontAwesomeIcon("usercircleo"), for: UIControlState.normal)
        btn.tintColor = UIColor.textColor
        btn.addTarget(self, action: #selector(handleProfileButton), for: .touchDown)
        return btn
    }()
    private var uploadPhotoBtn: UIButton = {
        let btn = UIButton(type: UIButtonType.system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = UIFont.icon(from: .materialIcon, ofSize: 35)
        btn.setTitle(String.fontMaterialIcon("image"), for: UIControlState.normal)
        btn.tintColor = UIColor.textColor
        btn.addTarget(self, action: #selector(handleUploadingPhoto), for: .touchDown)
        return btn
    }()
    private var takePhotoBtn: UIButton = {
        let btn = UIButton(type: UIButtonType.system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        //btn.setTitle("Take", for: UIControlState.normal)
        btn.backgroundColor = UIColor.mainColor
        btn.tintColor = UIColor.textColor
        btn.layer.cornerRadius = 40
        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        btn.addTarget(self, action: #selector(handleTakePhoto), for: .touchDown)
        return btn
    }()
    private var cameraAccessLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = App.label.homeLabelCameraAccess
        label.tintColor = UIColor.textColor
        label.textColor = UIColor.textColor
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    
    ///Main view setup
    override func setupView() {
        //required because programatically setting up views.
        translatesAutoresizingMaskIntoConstraints = false
        previewViewSetup()
        takePhotoBtnSetup()
        moreButtonSetup()
        profileButtonSetup()
        uploadPhotoButtonSetup()
        cameraAccessLabelSetup()
        
    }
    private func previewViewSetup() {
        addSubview(previewView)
        NSLayoutConstraint.activate([
            previewView.topAnchor.constraint(equalTo: topAnchor),
            previewView.bottomAnchor.constraint(equalTo: bottomAnchor),
            previewView.leadingAnchor.constraint(equalTo: leadingAnchor),
            previewView.trailingAnchor.constraint(equalTo: trailingAnchor)])
    }
    private func takePhotoBtnSetup() {
        addSubview(takePhotoBtn)
        NSLayoutConstraint.activate([
            takePhotoBtn.bottomAnchor.constraint(equalTo: previewView.bottomAnchor, constant: -20),
            takePhotoBtn.centerXAnchor.constraint(equalTo: previewView.centerXAnchor),
            takePhotoBtn.widthAnchor.constraint(equalToConstant: 80),
            takePhotoBtn.heightAnchor.constraint(equalToConstant: 80)
            ])
    }
    private func moreButtonSetup() {
        addSubview(logoutBtn)
        NSLayoutConstraint.activate([
            logoutBtn.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            logoutBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            ])
    }
    private func profileButtonSetup() {
        addSubview(profileBtn)
        NSLayoutConstraint.activate([
            profileBtn.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            profileBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            ])
    }
    private func uploadPhotoButtonSetup() {
        addSubview(uploadPhotoBtn)
        NSLayoutConstraint.activate([
            uploadPhotoBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            uploadPhotoBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
            ])
    }
    private func cameraAccessLabelSetup() {
        addSubview(cameraAccessLabel)
        NSLayoutConstraint.activate([
            cameraAccessLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            cameraAccessLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            cameraAccessLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            cameraAccessLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
            
            ])
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleCameraAccessTap))
        cameraAccessLabel.isUserInteractionEnabled = true
        cameraAccessLabel.addGestureRecognizer(tap)
    }
    @objc private func handleTakePhoto() {
        delegate.handleTakingPhoto()
    }
    @objc private func handleMoreButton() {
        delegate.handleMoreButton()
    }
    @objc private func handleProfileButton() {
        delegate.handleProfileButton()
    }
    @objc private func handleUploadingPhoto() {
        delegate.handleUploadingPhoto()
    }
    @objc private func handleCameraAccessTap() {
        delegate.handleCameraAccessTap()
    }
}

extension HomeView {
    ///CameraAccessLabel isHidden getter and setter
    public var isCameraAccessLabelHidden: Bool {
        get {
            return cameraAccessLabel.isHidden
        }
        set {
            cameraAccessLabel.isHidden = newValue
        }
    }
}

///HomeViewDelegate protocal to handle `HomeView` actions
protocol HomeViewDelegate {
    ///handle taking photo button
    func handleTakingPhoto()
    ///handle more button
    func handleMoreButton()
    ///handle profile button
    func handleProfileButton()
    ///handle upload button
    func handleUploadingPhoto()
    ///handle camera access tap to show alert
    func handleCameraAccessTap()
}
