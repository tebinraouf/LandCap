//
//  DetailView.swift
//  LandCapApp
//
//  Created by Tebin on 10/18/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import UIKit

class DetailView: BaseView {
    
    public var imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .blue
        return iv
    }()
    
    override func setupView() {
        backgroundColor = .mainLightGray
        imageSetup()
    }
    private func imageSetup() {
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 64),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 500)
            ])
    }
}
