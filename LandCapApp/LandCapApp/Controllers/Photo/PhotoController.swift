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
import CDAlertView

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
        
        let database = CapDatabase(userID: User.session.currentUserID)
        
        database.photoLimit { (limit) in
            if limit > 0 {
                let cloudDetector = self.vision.cloudLandmarkDetector()
                let image = UIImage(data: self.imageData)
                let visionImage = VisionImage(image: image!)
                cloudDetector.detect(in: visionImage) { (landmarks, error) in
                    if let error = error {
                        let alert = CDAlertView(title: App.label.visionError, message: error.localizedDescription, type: .error)
                        alert.show()
                        self.photoView.spinner.stopAnimating()
                    }
                    if let landmarks = landmarks {
                        if landmarks.isEmpty {
                            let alert = CDAlertView(title: App.label.notDetectedTitle, message: App.label.notDetectedMessage, type: .warning)
                            alert.show()
                            self.photoView.spinner.stopAnimating()
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
            else {
                var message = App.label.photoLimitMessage
                if User.session.isAnonymous {
                    message = App.label.photoLimitAnnonymousMessage
                }
                let alert = CDAlertView(title: App.label.photoLimitTitle, message: message, type: .warning)
                alert.show()
                self.photoView.spinner.stopAnimating()
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
