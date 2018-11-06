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

class HomeView: BaseView {
    
    public var previewView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.mainColor
        return view
    }()
    public var delegate: HomeViewDelegate!
    
    private var moreBtn: UIButton = {
        let btn = UIButton(type: UIButtonType.system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = UIFont.icon(from: .fontAwesome, ofSize: 25)
        btn.setTitle(String.fontAwesomeIcon("bars"), for: UIControlState.normal)
//        btn.backgroundColor = UIColor.mainColor
        btn.tintColor = UIColor.textColor
//        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        btn.addTarget(self, action: #selector(handleMoreButton), for: .touchDown)
        return btn
    }()
    private var uploadPhotoBtn: UIButton = {
        let btn = UIButton(type: UIButtonType.system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = UIFont.icon(from: .materialIcon, ofSize: 35)
        btn.setTitle(String.fontMaterialIcon("image"), for: UIControlState.normal)
//        btn.setTitle("Hellooooo", for: .normal)
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
    
    
    override func setupView() {
        //required because programatically setting up views.
        translatesAutoresizingMaskIntoConstraints = false
        previewViewSetup()
        takePhotoBtnSetup()
        moreButtonSetup()
        uploadPhotoButton()
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
        addSubview(moreBtn)
        NSLayoutConstraint.activate([
            moreBtn.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            moreBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            ])
    }
    private func uploadPhotoButton() {
        addSubview(uploadPhotoBtn)
        
        NSLayoutConstraint.activate([
            uploadPhotoBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            uploadPhotoBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
            ])
        
    }
    @objc func handleTakePhoto() {
        delegate.handleTakingPhoto()
    }
    @objc func handleMoreButton() {
        delegate.handleMoreButton()
    }
    @objc func handleUploadingPhoto() {
        delegate.handleUploadingPhoto()
    }
}

protocol HomeViewDelegate {
    func handleTakingPhoto()
    func handleMoreButton()
    func handleUploadingPhoto()
}