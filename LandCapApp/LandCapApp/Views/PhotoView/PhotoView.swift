//
//  PhotoView.swift
//  LandCapApp
//
//  Created by Tebin on 9/27/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import UIKit


class PhotoView: BaseView {
    
    var imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .whiteColor
        return iv
        
    }()
    
    override func setupView() {
        imageViewSetup()
        
    }
    
    private func imageViewSetup() {
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 500)])
    }
}

extension PhotoView {
    var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
        }
    }
}
