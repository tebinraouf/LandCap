//
//  ProfileView.swift
//  LandCapApp
//
//  Created by Tebin on 10/16/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import Foundation
import UIKit

///ProfileController view
class ProfileView: BaseView {
    ///User profile picture
    public var imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "profile_holder")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .clear
        iv.layer.cornerRadius = 50
        iv.layer.borderWidth = 0.5
        iv.layer.masksToBounds = true
        iv.isHidden = false
        iv.isUserInteractionEnabled = true
        return iv
    }()
    ///User name
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = UIFont(name: "Iowan Old Style", size: 20)
        label.numberOfLines = 2
        return label
    }()
    ///CollectionView for user image
    public var imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .mainLightGray
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isPagingEnabled = false
        return cv
    }()
    ///ProfileDelegate to handle view actions
    public var delegate: ProfileDelegate!
    
    ///Initial setup
    override func setupView() {
        backgroundColor = .mainLightGray
        imageViewSetup()
        nameLabelSetup()
        imageCollectionSetup()
    }
    private func imageViewSetup() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileTap(_:)))
        imageView.addGestureRecognizer(tap)
        
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 74),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            ])
    }
    private func nameLabelSetup() {
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            ])
    }
    private func imageCollectionSetup() {
        imageCollectionView.register(ProfileCell.self, forCellWithReuseIdentifier: CellID.ProfileCell)
        addSubview(imageCollectionView)
        NSLayoutConstraint.activate([
            imageCollectionView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            imageCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
            ])
    }
    @objc private func handleProfileTap(_ sender: UITapGestureRecognizer) {
        delegate.handleProfileTap()
    }
}

///Utility setters and getters
extension ProfileView {
    ///imageCollectionView delegate setter and getter
    public var collectionViewDelegate: UICollectionViewDelegate? {
        get {
            return imageCollectionView.delegate
        }
        set {
            imageCollectionView.delegate = newValue
        }
    }
    ///imageCollectionView dataSource setter and getter
    public var collectionViewDataSource: UICollectionViewDataSource? {
        get {
            return imageCollectionView.dataSource
        }
        set {
            imageCollectionView.dataSource = newValue
        }
    }
    ///User name getter and setter
    public var userName: String? {
        get {
            return nameLabel.text
        }
        set {
            nameLabel.text = newValue
        }
    }
}

///ProfileView delegate
protocol ProfileDelegate {
    ///Profile image tap handler
    func handleProfileTap()
}
