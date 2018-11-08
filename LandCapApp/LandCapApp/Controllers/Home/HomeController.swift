//
//  HomeController.swift
//  LandCapApp
//
//  Created by Tebin on 9/16/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import Foundation
import UIKit

///The main controller after the user is signed in
class HomeController: UIViewController {
    ///The HomeController view
    public var homeView: HomeView = HomeView()
    ///`CaptureCamera` instance
    public var captureCamera: CaptureCamera!
    
    ///Initial Controller load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //setup the view
        setupView()
        setupDelegate()
        
        //configure and setup the camera
        captureCamera = CaptureCamera(homeView, view.frame)
        captureCamera.setupCamera()
        
        //Configure Swiping
        handleSwipeGestureRecognizer()
    }
    ///viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    private func setupDelegate() {
        homeView.delegate = self
    }
    private func setupView() {
        view.addSubview(homeView)
        NSLayoutConstraint.activate([
            homeView.topAnchor.constraint(equalTo: view.topAnchor),
            homeView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            homeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeView.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
    }
    private func handleSwipeGestureRecognizer() {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeToProfile(sender:)))
        swipe.direction = UISwipeGestureRecognizerDirection.left
        view.addGestureRecognizer(swipe)
    }
}





