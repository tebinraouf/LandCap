//
//  InfoView.swift
//  LandCapApp
//
//  Created by Tebin on 10/12/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import UIKit



class InfoView: BaseView {
    
    var infoModel: InfoModel? {
        didSet {
            guard let info = infoModel else { return }
            imageView.image = createThumbnail(from: info.image!)
            titleLabel.text = info.title
            confidenceLabel.text = "Confidence: \(info.confidence!)"
        }
    }
    private var imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .blue
        iv.transform = CGAffineTransform(rotationAngle: .pi/2)
        return iv
    }()
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Statue of Liberty"
        label.font = UIFont(name: "Iowan Old Style", size: 30)
        return label
    }()
    private var confidenceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Confidence: 73%"
        label.font = UIFont(name: "Iowan Old Style", size: 20)
        return label
    }()
    override func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        imageViewSetup()
        titleLabelSetup()
        confidenceLabelSetup()
    }
    private func imageViewSetup() {
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 74),
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
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 74),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            ])
    }
    private func confidenceLabelSetup() {
        addSubview(confidenceLabel)
        NSLayoutConstraint.activate([
            confidenceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            confidenceLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            ])
    }
}
