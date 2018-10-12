//
//  PageController.swift
//  LandCapApp
//
//  Created by Tebin on 9/10/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import UIKit
import Firebase

class PageController: UIViewController {
    
    let pages : [Page] = {
        let page = Page()
        return page.getPages()
    }()
    let pageView = PageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print("PageController")
        
        setupView()
        setDelegates()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}

extension PageController {
    func setupView() {
        view.addSubview(pageView)
        NSLayoutConstraint.activate([
            pageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageView.topAnchor.constraint(equalTo: view.topAnchor),
            pageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    func setDelegates(){
        pageView.collectionViewDelegate = self
        pageView.collectionViewDataSource = self
        pageView.loginDelegate = self
        pageView.socialMediaDelegate = self
        pageView.setTextFieldsDelegate(self)
    }
    func nextController() {
        navigationController?.pushViewController(HomeController(), animated: true)
    }
    func handling(_ error: Error?) {
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
