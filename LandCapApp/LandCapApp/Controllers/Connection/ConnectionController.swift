//
//  NoConnectionController.swift
//  LandCapApp
//
//  Created by Tebin on 11/18/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import UIKit


///The connection controller for no internet connection availability
class ConnectionController: UIViewController {
    
    private let connectionView = ConnectionView()
    
    ///viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainColor
        setupView()
        listenForConnection()
    }
    ///viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        listenForConnection()
    }
    private func setupView() {
        view.addSubview(connectionView)
        NSLayoutConstraint.activate([
            connectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            connectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            connectionView.topAnchor.constraint(equalTo: view.topAnchor),
            connectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    private func listenForConnection() {
        if Reachability.isConnectedToNetwork {
            var viewController: UIViewController!
            if User.session.isSignedIn {
                viewController = HomeController()
            } else {
                viewController = PageController()
            }
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    

}
