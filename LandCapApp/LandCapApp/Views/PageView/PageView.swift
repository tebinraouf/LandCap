//
//  PageView.swift
//  LandCapApp
//
//  Created by Tebin on 9/10/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import UIKit

class PageView: BaseView {
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isPagingEnabled = true
        return cv
    }()
    var logoLabel: UILabel = {
        let label = UILabel()
        label.text = "LandCap"
        label.tintColor = .white
        label.textColor = .white
        label.backgroundColor = .clear
        label.font = UIFont(name: "Iowan Old Style", size: 70)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var getStartedBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = .lightGray
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.numberOfPages = 4 //self.pages.count + 1
        pc.currentPageIndicatorTintColor = .orange
        return pc
    }()
    var getStartedButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        let btnName = NSLocalizedString("Get Started", comment: "skip to login view")
        btn.setTitle(btnName, for: .normal)
        btn.backgroundColor = .orange
        btn.tintColor = .white
        btn.layer.cornerRadius = 20
        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        btn.addTarget(self, action: #selector(handleGetStarted), for: .touchDown)
        return btn
    }()
    var loginView = LoginView()
    var centerConstraint: NSLayoutConstraint!
    var getStartedConstraint: NSLayoutConstraint!
    var pageControlConstraint: NSLayoutConstraint!
    
    override func setupView() {
        collectionViewSetup()
        logoLabelViewSetup()
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: CellID.PageCell)
        setupGetStartedBackground()
        
        setupPageControl()
        setupGetStartedButton()
        setupLoginView()
    }
    func collectionViewSetup() {
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: -44),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -150)
            ])
    }
    func setupGetStartedBackground(){
        addSubview(getStartedBackground)
        NSLayoutConstraint.activate([
            getStartedBackground.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            getStartedBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            getStartedBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            getStartedBackground.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    func logoLabelViewSetup() {
        addSubview(logoLabel)
        NSLayoutConstraint.activate([
            logoLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            logoLabel.heightAnchor.constraint(equalTo: logoLabel.heightAnchor),
            logoLabel.widthAnchor.constraint(equalTo: logoLabel.widthAnchor),
            logoLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
    }
    func setupPageControl(){
        addSubview(pageControl)
        pageControlConstraint = pageControl.centerXAnchor.constraint(equalTo: getStartedBackground.centerXAnchor)
        pageControlConstraint.isActive = true
        NSLayoutConstraint.activate([
            pageControl.heightAnchor.constraint(equalTo: pageControl.heightAnchor),
            pageControl.widthAnchor.constraint(equalTo: pageControl.widthAnchor),
            pageControl.topAnchor.constraint(equalTo: getStartedBackground.topAnchor, constant: 30)
            ])
    }
    func setupGetStartedButton(){
        addSubview(getStartedButton)
        getStartedConstraint = getStartedButton.centerXAnchor.constraint(equalTo: getStartedBackground.centerXAnchor)
        getStartedConstraint.isActive = true
        NSLayoutConstraint.activate(
            [getStartedButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
             getStartedButton.heightAnchor.constraint(equalTo: getStartedButton.heightAnchor),
             getStartedButton.widthAnchor.constraint(equalTo: getStartedButton.widthAnchor),
             ])
    }
    func setupLoginView() {
        addSubview(loginView)
        let top = loginView.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 60)
        let width = loginView.widthAnchor.constraint(equalTo: widthAnchor, constant: -40)
        let bottom = loginView.bottomAnchor.constraint(equalTo: bottomAnchor)
        centerConstraint = loginView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 400)
        centerConstraint.isActive = true
        let constraints = [top, width, bottom]
        NSLayoutConstraint.activate(constraints)
    }
    func updateConstraintFor(getStarted: CGFloat, pageControl: CGFloat, loginView: CGFloat, facebookBtn: CGFloat){
        getStartedConstantConstraint = getStarted
        pageControlConstantConstraint = pageControl
        loginViewConstantConstraint = loginView
//        fbConstantConstraint = facebookBtn
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
    @objc func handleGetStarted() {
        loginDelegate.getStartedBtn()
    }
    func keyboardResponder(){
        loginView.keyboardResponder()
    }
    func setTextFieldsDelegate(_ delegate: UITextFieldDelegate?){
        loginView.nameTextField.delegate = delegate
        loginView.emailTextField.delegate = delegate
        loginView.passTextField.delegate = delegate
    }
}


extension PageView {
    var pageCollectionView: UICollectionView {
        get {
            return collectionView
        }
    }
    var collectionViewDelegate: UICollectionViewDelegate? {
        get {
            return collectionView.delegate
        }
        set {
            collectionView.delegate = newValue
        }
    }
    var collectionViewDataSource: UICollectionViewDataSource? {
        get {
            return collectionView.dataSource
        }
        set {
            collectionView.dataSource = newValue
        }
    }
    var currentPage: Int {
        get {
            return pageControl.currentPage
        }
        set {
            pageControl.currentPage = newValue
        }
    }
    var getStartedConstantConstraint: CGFloat {
        get {
            return getStartedConstraint.constant
        }
        set {
            getStartedConstraint.constant = newValue
        }
    }
    var pageControlConstantConstraint: CGFloat {
        get {
            return pageControlConstraint.constant
        }
        set {
            pageControlConstraint.constant = newValue
        }
    }
    var loginViewConstantConstraint: CGFloat {
        get {
            return centerConstraint.constant
        }
        set {
            centerConstraint.constant = newValue
        }
    }
    var loginDelegate: LoginViewDelegate {
        get {
            return loginView.loginDelegate
        }
        set {
            loginView.loginDelegate = newValue
        }
    }
}




