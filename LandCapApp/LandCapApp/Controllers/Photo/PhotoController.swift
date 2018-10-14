//
//  PhotoController.swift
//  LandCapApp
//
//  Created by Tebin on 9/26/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import Foundation
import Firebase
import UIKit


class PhotoController: UIViewController {

    var imageData: Data!
    let photoView = PhotoView()
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: App.label.processPhoto, style: UIBarButtonItemStyle.done, target: self, action: #selector(processHandler))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: App.label.cancelPhoto, style: UIBarButtonItemStyle.done, target: self, action: #selector(cancleHandler))
    }
}

extension PhotoController {
    @objc func processHandler() {
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
                    let infoController = InfoController()
                    infoController.landmarks = landmarks
                    infoController.processedImage = image!
                    let navController = UINavigationController(rootViewController: infoController)
                    self.present(navController, animated: true, completion: nil)
                }
            }
        }
    }
    @objc func cancleHandler() {
        self.dismiss(animated: true, completion: nil)
    }
}
