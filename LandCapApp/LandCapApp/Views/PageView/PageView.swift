//
//  PageView.swift
//  LandCapApp
//
//  Created by Tebin on 9/10/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import UIKit
import FBSDKLoginKit
///PageController View
class PageView: BaseView {
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isPagingEnabled = true
        return cv
    }()
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
    private var getStartedBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = .lightGray
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.numberOfPages = 4 //self.pages.count + 1
        pc.currentPageIndicatorTintColor = UIColor.mainColor
        return pc
    }()
    private var getStartedButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(App.label.getStartedButton, for: .normal)
        btn.backgroundColor = UIColor.mainColor
        btn.tintColor = UIColor.textColor
        btn.layer.cornerRadius = 20
        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        btn.addTarget(self, action: #selector(handleGetStarted), for: .touchDown)
        return btn
    }()
    private var skipBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(App.label.skipButton, for: .normal)
        btn.backgroundColor = UIColor.clear
        btn.tintColor = UIColor.textColor
        btn.addTarget(self, action: #selector(handleSkip), for: .touchDown)
        return btn
    }()
    ///LoginView instance
    public var loginView = LoginView()
    ///SocialLoginView instance
    var socialLoginView = SocialMediaLoginView()
    ///centerConstraint animation constraint
    var centerConstraint: NSLayoutConstraint!
    ///getStartedConstraint animation constraint
    var getStartedConstraint: NSLayoutConstraint!
    ///skipConstraint animation constraint
    var skipConstraint: NSLayoutConstraint!
    ///pageControlConstraint animation constraint
    var pageControlConstraint: NSLayoutConstraint!
    ///socialLoginCenterConstraint animation constraint
    var socialLoginCenterConstraint: NSLayoutConstraint!
    ///view delegate
    var delegate: PageViewDelegate!
    //initial setup
    override func setupView() {
        collectionViewSetup()
        logoLabelViewSetup()
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: CellID.PageCell)
        setupGetStartedBackground()
        setupSkipButton()
        
        setupPageControl()
        setupGetStartedButton()
        setupLoginView()
        setupSocialMediaView()
    }
    private func collectionViewSetup() {
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: -44),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -150)
            ])
    }
    private func setupGetStartedBackground(){
        addSubview(getStartedBackground)
        NSLayoutConstraint.activate([
            getStartedBackground.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            getStartedBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            getStartedBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            getStartedBackground.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
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
    private func setupPageControl(){
        addSubview(pageControl)
        pageControlConstraint = pageControl.centerXAnchor.constraint(equalTo: getStartedBackground.centerXAnchor)
        pageControlConstraint.isActive = true
        NSLayoutConstraint.activate([
            pageControl.heightAnchor.constraint(equalTo: pageControl.heightAnchor),
            pageControl.widthAnchor.constraint(equalTo: pageControl.widthAnchor),
            pageControl.topAnchor.constraint(equalTo: getStartedBackground.topAnchor, constant: 30)
            ])
    }
    private func setupGetStartedButton(){
        addSubview(getStartedButton)
        getStartedConstraint = getStartedButton.centerXAnchor.constraint(equalTo: getStartedBackground.centerXAnchor)
        getStartedConstraint.isActive = true
        NSLayoutConstraint.activate(
            [getStartedButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
             getStartedButton.heightAnchor.constraint(equalTo: getStartedButton.heightAnchor),
             getStartedButton.widthAnchor.constraint(equalTo: getStartedButton.widthAnchor),
             ])
    }
    private func setupSkipButton(){
        addSubview(skipBtn)
        skipConstraint = skipBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: 100)
        skipConstraint.isActive = true
    }
    private func setupLoginView() {
        addSubview(loginView)
        let top = loginView.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 60)
        let width = loginView.widthAnchor.constraint(equalTo: widthAnchor, constant: -40)
        let bottom = loginView.bottomAnchor.constraint(equalTo: bottomAnchor)
        centerConstraint = loginView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 400)
        centerConstraint.isActive = true
        let constraints = [top, width, bottom]
        NSLayoutConstraint.activate(constraints)
    }
    private func setupSocialMediaView() {
        addSubview(socialLoginView)
        let width = socialLoginView.widthAnchor.constraint(equalTo: widthAnchor, constant: -40)
        let centerY = socialLoginView.centerYAnchor.constraint(equalTo: getStartedBackground.centerYAnchor)
        let height = socialLoginView.heightAnchor.constraint(equalToConstant: 40)
        socialLoginCenterConstraint = socialLoginView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 400)
        socialLoginCenterConstraint.isActive = true
        NSLayoutConstraint.activate([width, centerY, height])
    }
    ///Update constraints on user interactions
    /// - Parameter getStarted: GetStarted button constraint
    /// - Parameter skip: Skip button constraint
    /// - Parameter pageControl: PageControll button constraint
    /// - Parameter loginView: `LoginView` constraint
    /// - Parameter socialLoginBtn:  Facebook button constraint
    ///
    /// - Returns: Void
    public func updateConstraintFor(getStarted: CGFloat, skip: CGFloat ,pageControl: CGFloat, loginView: CGFloat, socialLoginBtn: CGFloat){
        getStartedConstantConstraint = getStarted
        skipConstantConstraint = skip
        pageControlConstantConstraint = pageControl
        loginViewConstantConstraint = loginView
        socialLoginCenterConstraint.constant = socialLoginBtn
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
    @objc private func handleGetStarted() {
        let indexPath = IndexPath(item: 3, section: 0)
        pageCollectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.left, animated: true)
        updateConstraintFor(getStarted: -300, skip: -20, pageControl: -300, loginView: 0, socialLoginBtn: 0)
    }
    @objc private func handleSkip() {
        loginDelegate.skipBtn()
    }
    ///Handle keyboard responsiveness
    public func keyboardResponder(){
        loginView.keyboardResponder()
    }
    ///LoginView component delegate
    func setTextFieldsDelegate(_ delegate: UITextFieldDelegate?){
        loginView.nameTextField.delegate = delegate
        loginView.emailTextField.delegate = delegate
        loginView.passTextField.delegate = delegate
    }
    override func layoutMarginsDidChange() {
        skipBtn.topAnchor.constraint(equalTo: topAnchor, constant: delegate.topDistance - 40).isActive = true
    }
}

///Setter and Getter
extension PageView {
    ///PageCollectionView getter
    var pageCollectionView: UICollectionView {
        get {
            return collectionView
        }
    }
    ///CollectionView Delegate getter and setter
    var collectionViewDelegate: UICollectionViewDelegate? {
        get {
            return collectionView.delegate
        }
        set {
            collectionView.delegate = newValue
        }
    }
    ///CollectionView DataSource getter and setter
    var collectionViewDataSource: UICollectionViewDataSource? {
        get {
            return collectionView.dataSource
        }
        set {
            collectionView.dataSource = newValue
        }
    }
    ///Current Page getter and setter
    var currentPage: Int {
        get {
            return pageControl.currentPage
        }
        set {
            pageControl.currentPage = newValue
        }
    }
    ///getStartedConstraint getter and setter
    var getStartedConstantConstraint: CGFloat {
        get {
            return getStartedConstraint.constant
        }
        set {
            getStartedConstraint.constant = newValue
        }
    }
    ///skipConstraint getter and setter
    var skipConstantConstraint: CGFloat {
        get {
            return skipConstraint.constant
        }
        set {
            skipConstraint.constant = newValue
        }
    }
    ///pageControlConstraint getter and setter
    var pageControlConstantConstraint: CGFloat {
        get {
            return pageControlConstraint.constant
        }
        set {
            pageControlConstraint.constant = newValue
        }
    }
    ///centerConstraint getter and setter
    var loginViewConstantConstraint: CGFloat {
        get {
            return centerConstraint.constant
        }
        set {
            centerConstraint.constant = newValue
        }
    }
    ///LoginViewDelegate getter and setter
    var loginDelegate: LoginViewDelegate {
        get {
            return loginView.loginDelegate
        }
        set {
            loginView.loginDelegate = newValue
        }
    }
    ///SocialMediaLoginDelegate getter and setter
    var socialMediaDelegate: SocialMediaLoginDelegate {
        get {
            return socialLoginView.socialMediaDelegate
        }
        set {
            socialLoginView.socialMediaDelegate = newValue
        }
    }
}

//PageView Delegate
public protocol PageViewDelegate {
    ///Get the top distance height from controller
    var topDistance: CGFloat {get}
}




