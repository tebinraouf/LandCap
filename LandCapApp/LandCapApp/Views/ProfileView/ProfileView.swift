//
//  ProfileView.swift
//  LandCapApp
//
//  Created by Tebin on 10/16/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import Foundation
import UIKit

class ProfileView: BaseView {
    private var imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .mainColor
        iv.layer.cornerRadius = 50
        iv.layer.borderWidth = 0.5
        iv.layer.masksToBounds = true
        iv.isHidden = false
        iv.transform = CGAffineTransform(rotationAngle: .pi/2)
        return iv
    }()
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "John Smith"
        label.font = UIFont(name: "Iowan Old Style", size: 20)
        label.numberOfLines = 2
        return label
    }()
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
    override func setupView() {
        backgroundColor = .mainLightGray
        
        imageViewSetup()
        nameLabelSetup()
        imageCollectionSetup()
    }
    private func imageViewSetup() {
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
}

extension ProfileView {
    public var collectionViewDelegate: UICollectionViewDelegate? {
        get {
            return imageCollectionView.delegate
        }
        set {
            imageCollectionView.delegate = newValue
        }
    }
    public var collectionViewDataSource: UICollectionViewDataSource? {
        get {
            return imageCollectionView.dataSource
        }
        set {
            imageCollectionView.dataSource = newValue
        }
    }
}
