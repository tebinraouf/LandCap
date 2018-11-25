//
//  InfoView.swift
//  LandCapApp
//
//  Created by Tebin on 10/12/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import UIKit


///InfoController view
class InfoView: BaseView {
    
    ///View Delegate
    public var delegate: InfoViewDelegate!
    
    ///InfoController model to fill the view components
    public var infoModel: InfoModel? {
        didSet {
            guard let info = infoModel else { return }
            imageView.image = createThumbnail(from: info.image!)
            titleLabel.text = info.title
            confidenceLabel.text = "Confidence: \(info.confidence!)%"
        }
    }
    private var imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .clear
        iv.layer.cornerRadius = 20
        iv.layer.borderWidth = 0.5
        iv.layer.masksToBounds = true
        iv.isHidden = true
//        iv.transform = CGAffineTransform(rotationAngle: .pi/2)
        return iv
    }()
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.text = "Statue of Liberty"
        label.font = UIFont(name: "Iowan Old Style", size: 25)
        label.numberOfLines = 2
        return label
    }()
    private var confidenceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.text = "Confidence: 73%"
        label.font = UIFont(name: "Iowan Old Style", size: 20)
        return label
    }()
    ///A UIActivityIndicatorView instance to handle loading when processing
    public var spinner: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        ai.translatesAutoresizingMaskIntoConstraints = false
        return ai
    }()
    ///The UICollectionView instance to show wiki text
    public var wikiCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .mainLightGray
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isPagingEnabled = false
        return cv
    }()
    ///Initial setup
    override func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .mainLightGray
        
        imageViewSetup()
        titleLabelSetup()
        confidenceLabelSetup()
        
        wikiCollectionView.register(InfoCell.self, forCellWithReuseIdentifier: CellID.InfoCell)
        wikiCollectionSetup()
        spinnerSetup()
    }
    private func imageViewSetup() {
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            ])
    }
    private func createThumbnail(from image: UIImage) -> UIImage {
        let imageData = UIImagePNGRepresentation(image)
        let options = [
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceThumbnailMaxPixelSize: 300] as CFDictionary
        let source = CGImageSourceCreateWithData(imageData! as CFData, nil)!
        let imageReference = CGImageSourceCreateThumbnailAtIndex(source, 0, options)!
        let thumbnail = UIImage(cgImage: imageReference)
        return thumbnail
    }
    private func titleLabelSetup() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            ])
        layoutIfNeeded()
    }
    private func confidenceLabelSetup() {
        addSubview(confidenceLabel)
        NSLayoutConstraint.activate([
            confidenceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            confidenceLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            ])
    }
    private func wikiCollectionSetup() {
        addSubview(wikiCollectionView)
        NSLayoutConstraint.activate([
            wikiCollectionView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            wikiCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            wikiCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            wikiCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
            ])
    }
    private func spinnerSetup() {
        addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }
    ///layoutMarginsDidChange
    override func layoutMarginsDidChange() {
        ///calculate top anchor based on navigation bar height taken from the controller
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: delegate.topDistance + 10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: delegate.topDistance + 10).isActive = true
        layoutIfNeeded()
    }
}

///Utility getters and setters
extension InfoView {
    /// UICollectionViewDelegate getter and setter
    public var collectionViewDelegate: UICollectionViewDelegate? {
        get {
            return wikiCollectionView.delegate
        }
        set {
            wikiCollectionView.delegate = newValue
        }
    }
    /// UICollectionViewDataSource getter and setter
    public var collectionViewDataSource: UICollectionViewDataSource? {
        get {
            return wikiCollectionView.dataSource
        }
        set {
            wikiCollectionView.dataSource = newValue
        }
    }
    ///ImageView visibility getter and setter
    public var imageViewIsHidden: Bool {
        get {
            return imageView.isHidden
        }
        set {
            imageView.isHidden = newValue
        }
    }
}


///InfoView Delegate
protocol InfoViewDelegate {
    ///Get the top distance height from controller
    var topDistance: CGFloat {get}
}
