//
//  PhotoController.swift
//  LandCapApp
//
//  Created by Tebin on 9/26/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import SwiftIconFont


class PhotoController: UIViewController {

    var imageData: Data!
    let photoView = PhotoView()
    
    weak var homeController: HomeController!
    lazy var vision = Vision.vision()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor  = UIColor.whiteColor
        setNavigationItems()
        setupView()
        photoView.image = UIImage(data: imageData)
        print("PhotoController")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    private func setupView() {
        view.addSubview(photoView)
        NSLayoutConstraint.activate([
            photoView.topAnchor.constraint(equalTo: view.topAnchor),
            photoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photoView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    private func setNavigationItems() {
        let processButton = UIBarButtonItem()
        processButton.action = #selector(processHandler)
        processButton.target = self
        processButton.tintColor = .mainColor
        processButton.title = "Process"
        navigationItem.leftBarButtonItem = processButton
        
        let cancelButton =  UIBarButtonItem()
        cancelButton.action = #selector(cancelHandler)
        cancelButton.target = self
        cancelButton.tintColor = .mainColor
        cancelButton.icon(from: .fontAwesome, code: "timescircle", ofSize: 25)
        
        let historyButton = UIBarButtonItem()
        historyButton.action = #selector(historyHandler)
        historyButton.target = self
        historyButton.width = 75
        historyButton.tintColor = .mainColor
        historyButton.icon(from: .fontAwesome, code: "history", ofSize: 25)
        
        navigationItem.rightBarButtonItems = [cancelButton, historyButton]
    }
}

extension PhotoController {
    @objc func processHandler() {
        photoView.spinner.startAnimating()
        let cloudDetector = vision.cloudLandmarkDetector()
        let image = UIImage(data: imageData)
        
        let visionImage = VisionImage(image: image!)
        cloudDetector.detect(in: visionImage) { (landmarks, error) in
            
            if let error = error {
                alert(title: App.label.visionError, message: error.localizedDescription, viewController: self)
            }
            
            if let landmarks = landmarks {
                if landmarks.isEmpty {
                    alert(title: App.label.notDetectedTitle, message: App.label.notDetectedMessage, viewController: self)
                }
                else {
                    self.photoView.spinner.stopAnimating()
                    let infoController = InfoController()
                    infoController.homeController = self.homeController
                    infoController.landmarks = landmarks
                    infoController.imageData = self.imageData
                    let navController = UINavigationController(rootViewController: infoController)
                    self.present(navController, animated: true, completion: nil)
                }
            }
        }
    }
    @objc func cancelHandler() {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func historyHandler() {
        print("Handle History")
    }
}
