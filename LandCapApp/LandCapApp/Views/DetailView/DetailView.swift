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
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .blue
        return iv
    }()
    public var imageText: UITextView = {
        let tv = UITextView()
        tv.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .mainLightGray
        tv.isEditable = false
        tv.textAlignment = .left
        tv.isScrollEnabled = true
        tv.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tv.layer.borderColor = UIColor.lightGray.cgColor
        tv.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        tv.isSelectable = false
        tv.setContentOffset(CGPoint.zero, animated: true)
        return tv
    }()
    
    override func setupView() {
        backgroundColor = .mainLightGray
        imageSetup()
        textViewSetup()
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
    private func textViewSetup() {
        addSubview(imageText)
        NSLayoutConstraint.activate([
            imageText.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            imageText.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageText.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageText.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
}
