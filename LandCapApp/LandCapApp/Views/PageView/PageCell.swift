//
//  PageCell.swift
//  LandCapApp
//
//  Created by Tebin on 9/10/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import UIKit

///PageController UICollection cell
class PageCell: BaseCell {
    
    ///Page model
    public var page: Page? {
        didSet {
            guard let page = page else { return }
            imageView.image = page.image
            titleLabel.text = page.title
            descriptionLabel.text = page.description
        }
    }
    ///Page imageview
    public var imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .clear
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleToFill
        return iv
    }()
    ///Page title
    public var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title"
        label.textColor = UIColor.textColor
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    ///Page description
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Description"
        label.textColor = UIColor.textColor
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 4
        label.textAlignment = .center
        return label
    }()
    private var gradientLayer = CAGradientLayer()
    ///Initial setup
    override func setupView() {
        setupGradientColor()
        addSubViews()
        backgroundSetup()
        titleSetup()
        descriptionSetup()
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
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
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
    ///LoginView delegate
    var loginView: LoginView?
    ///touchesBegan to handle keyboard responsiveness
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let loginView = loginView {
            loginView.keyboardResponder()
        }
    }

}
