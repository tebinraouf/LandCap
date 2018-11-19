//
//  ConnectionView.swift
//  LandCapApp
//
//  Created by Tebin on 11/18/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import UIKit

///The View of the ConnectionController
class ConnectionView: BaseView {
    
    ///LandCap Logo
    private var logoLabel: UILabel = {
        let label = UILabel()
        label.text = "LandCap" //App.label.appName
        label.tintColor = .white
        label.textColor = .white
        label.backgroundColor = .clear
        label.font = UIFont(name: "Iowan Old Style", size: 70)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    ///Page imageview
    private var imageView: UIImageView = {
        let iv = UIImageView()
        let image = UIImage(named: "wifi-off.png")
        let tintedImage = image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        iv.image = tintedImage
        iv.backgroundColor = .clear
        iv.tintColor = .mainLightGray
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    ///Page title
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No Internet Connection"
        label.textColor = UIColor.textColor
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    ///Page description
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Oops...You have no Internet connection. Please try again!"
        label.textColor = UIColor.textColor
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 4
        label.textAlignment = .center
        return label
    }()
    private var gradientLayer = CAGradientLayer()
    ///Setup initial view
    override func setupView() {
        setupGradientColor()
        logoLabelViewSetup()
        addSubViews()
        backgroundSetup()
        titleSetup()
        descriptionSetup()
    }
    private func logoLabelViewSetup() {
        addSubview(logoLabel)
        NSLayoutConstraint.activate([
            logoLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            logoLabel.heightAnchor.constraint(equalTo: logoLabel.heightAnchor),
            logoLabel.widthAnchor.constraint(equalTo: logoLabel.widthAnchor),
            logoLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
    }
    ///layoutSubviews
    override func layoutSubviews() {
        setupView()
    }
    private func addSubViews(){
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
    }
    private func backgroundSetup(){
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200)
            ])
    }
    private func titleSetup(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
    }
    private func descriptionSetup(){
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)
            ])
    }
    private func setupGradientColor() {
        layer.addSublayer(gradientLayer)
        gradientLayer.colors = [UIColor.mainColor.cgColor, UIColor.secondaryColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
    }
}

