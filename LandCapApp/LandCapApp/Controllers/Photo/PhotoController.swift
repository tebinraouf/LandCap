//
//  PhotoController.swift
//  LandCapApp
//
//  Created by Tebin on 9/26/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import Foundation
import UIKit

class PhotoController: UIViewController {

    var imageData: Data!
    let photoView = PhotoView()
    
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
        let database = CapDatabase(userID: userID)
        //image URL
        database.uploadImage(imageData: imageData) { (url) in
            alert(title: "Upload Successful", message: "", viewController: self)
            print(url)
        }
    }
    @objc func cancleHandler() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension PhotoController: PhotoViewDelegate {

}
