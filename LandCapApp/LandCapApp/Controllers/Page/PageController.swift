//
//  PageController.swift
//  LandCapApp
//
//  Created by Tebin on 9/10/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import UIKit
import Firebase

///Initial onborading controller
class PageController: UIViewController {
    
    ///PageController model
    public let pages : [Page] = {
        let page = Page()
        return page.getPages()
    }()
    ///PageController view
    let pageView = PageView()
    
    ///Initial load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print("PageController")
        
        setupView()
        setDelegates()
    }
    ///viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    ///preferredStatusBarStyle
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    private func calculateTopDistance() -> CGFloat {
        guard let navigationHeight = self.navigationController?.navigationBar.frame.height else {return 0}
        let statusHeight = UIApplication.shared.statusBarFrame.height
        return navigationHeight + statusHeight
    }
}

extension PageController {
    private func setupView() {
        view.addSubview(pageView)
        NSLayoutConstraint.activate([
            pageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageView.topAnchor.constraint(equalTo: view.topAnchor),
            pageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    private func setDelegates(){
        pageView.collectionViewDelegate = self
        pageView.collectionViewDataSource = self
        pageView.loginDelegate = self
        pageView.socialMediaDelegate = self
        pageView.setTextFieldsDelegate(self)
        pageView.delegate = self
    }
    ///NextController on success
    public func nextController() {
        navigationController?.pushViewController(HomeController(), animated: true)
    }
    ///Error handling
    public func handling(_ error: Error?) {
        if error != nil {
            if let errCode = AuthErrorCode(rawValue: (error?._code)!) {
                switch errCode {
                case .emailAlreadyInUse:
                    alert(title: App.label.email, message: (error?.localizedDescription)!, viewController: self)
                case .invalidEmail:
                    alert(title: App.label.email, message: (error?.localizedDescription)!, viewController: self)
                case .weakPassword:
                    let password = App.label.password
                    alert(title: password, message: (error?.localizedDescription)!, viewController: self)
                case .wrongPassword:
                    alert(title: App.label.password, message: (error?.localizedDescription)!, viewController: self)
                case .internalError:
                    alert(title: App.label.internalError, message: (error?.localizedDescription)!, viewController: self)
                default:
                    alert(title: App.label.oops, message: (error?.localizedDescription)!, viewController: self)
                }
            }
            return
        }
    }
}

extension PageController: PageViewDelegate {
    var topDistance: CGFloat {
        return calculateTopDistance()
    }
    
    
}
