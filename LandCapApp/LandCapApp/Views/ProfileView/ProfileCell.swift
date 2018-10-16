//
//  ProfileCell.swift
//  LandCapApp
//
//  Created by Tebin on 10/16/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import UIKit

class ProfileCell: BaseCell {
    private var imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .clear
        iv.contentMode = .scaleToFill
        iv.layer.borderWidth = 0.5
        return iv
    }()
    override func setupView() {
        imageViewSetup()
        imageView.image = (UIImage(named: "statue.png")!).cropToBounds(width: 137, height: 137)
    }
    private func imageViewSetup() {
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
}


