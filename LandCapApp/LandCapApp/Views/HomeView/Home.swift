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
    @objc func handleTakePhoto() {
        delegate.handleTakingPhoto()
    }
}

protocol HomeViewDelegate {
    func handleTakingPhoto()
}
