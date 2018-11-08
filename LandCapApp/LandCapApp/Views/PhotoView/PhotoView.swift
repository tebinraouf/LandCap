//
//  PhotoView.swift
//  LandCapApp
//
//  Created by Tebin on 9/27/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import UIKit

///PhotoController view
class PhotoView: BaseView {
    
    private var imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .whiteColor
        return iv
    }()
    ///UIActivityIndicatorView for UI
    public var spinner: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        ai.translatesAutoresizingMaskIntoConstraints = false
        return ai
    }()
    ///Initial setup
    override func setupView() {
        imageViewSetup()
        spinnerSetup()
    }
    private func imageViewSetup() {
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 500)])
    }
    private func spinnerSetup() {
        addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }
}

extension PhotoView {
    ///Taken image getter and setter
    public var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
        }
    }
}
