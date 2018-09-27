//
//  HomeController.swift
//  LandCapApp
//
//  Created by Tebin on 9/16/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import Foundation
import UIKit


class HomeController: UIViewController {
    
    var homeView: HomeView = HomeView()
    var captureCamera: CaptureCamera!
    
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
    func setupDelegate() {
        homeView.delegate = self
    }
    func setupView() {
        view.addSubview(homeView)
        NSLayoutConstraint.activate([
            homeView.topAnchor.constraint(equalTo: view.topAnchor),
            homeView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            homeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeView.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
    }
    func handleSwipeGestureRecognizer() {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeToProfile(sender:)))
        swipe.direction = UISwipeGestureRecognizerDirection.left
        view.addGestureRecognizer(swipe)
    }
}





