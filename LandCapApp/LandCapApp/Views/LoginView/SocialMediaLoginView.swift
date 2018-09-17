//
//  SocialMedia.swift
//  LandCapApp
//
//  Created by Tebin on 9/17/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import UIKit


class SocialMediaLoginView: BaseView {
    var delegate: SocialMediaLoginViewDelegate!
    lazy var instagramImageView: UIImageView = {
        let image = UIImage(named: "signWithInstagram")
        let iv = UIImageView(image: image)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(instagramHandler(tapGestureRecognizer:)))
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(tapGestureRecognizer)
        return iv
    }()
    override func setupView() {
        super.setupView()
        translatesAutoresizingMaskIntoConstraints = false
        setupImageView()
    }
    func setupImageView() {
        addSubview(instagramImageView)
        NSLayoutConstraint.activate([
            instagramImageView.topAnchor.constraint(equalTo: topAnchor),
            instagramImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            instagramImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            instagramImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    @objc func instagramHandler(tapGestureRecognizer: UITapGestureRecognizer) {
        delegate.instagramHandler()
    }
}



protocol SocialMediaLoginViewDelegate {
    func instagramHandler()
}
