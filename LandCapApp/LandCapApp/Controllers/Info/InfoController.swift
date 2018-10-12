//
//  InfoController.swift
//  LandCapApp
//
//  Created by Tebin on 10/12/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import UIKit
import Firebase

class InfoController: UIViewController {
    
    var landmarks: [VisionCloudLandmark]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print("InfoController")
        setNavigationItems()
    }
    
    private func setNavigationItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancleHandler))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveHandler))
    }
}

extension InfoController {
    @objc private func saveHandler() {
        print("save photo...")
    }
    @objc private func cancleHandler() {
        //Back to the Camera
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
