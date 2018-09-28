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
//        setupDelegate()
        photoView.image = UIImage(data: imageData)
        
        print("PhotoController")
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    private func setupDelegate() {
        photoView.delegate = self
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneHandler))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancleHandler))
    }
    @objc func doneHandler() {
        //upload photo to firebase
        let userID = User.session.currentUserID

        
        let cloudDetector = vision.cloudLandmarkDetector()
        let image = UIImage(data: imageData)
        
        
        
        let visionImage = VisionImage(image: image!)
        cloudDetector.detect(in: visionImage) { (landmarks, error) in
            
            if let error = error {
                alert(title: "Error!", message: error.localizedDescription, viewController: self)
            }
            
            if let landmarks = landmarks {
                
                if landmarks.isEmpty {
                    alert(title: "No Landmark", message: "", viewController: self)
                }
                else {
                    if let landmark = landmarks.first {
                        if let con = landmark.confidence, let land = landmark.landmark {
                            alert(title: "Landmark Detection", message: "Confidence: \(con)\n\(land)", viewController: self)
                        }
                    }
                }
//                for landmark in landmarks {
//                    print(landmark.confidence)
//                    print(landmark.landmark)
//
//                }
            }
        }
        
        
        //        let database = CapDatabase(userID: userID)
//        //image URL
//
//
//
//        database.uploadImage(imageData: imageData) { (url) in
//            alert(title: "Upload Successful", message: "", viewController: self)
//            print(url)
//
//
//
//        }
    }
    @objc func cancleHandler() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension PhotoController: PhotoViewDelegate {

}
