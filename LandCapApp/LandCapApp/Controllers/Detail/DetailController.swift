//
//  DetailController.swift
//  LandCapApp
//
//  Created by Tebin on 10/17/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import UIKit
import FirebaseUI

class DetailController: UIViewController {
    
    public var userImage: UserImage!
    
    private var detailView = DetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setNavigationItems()
        
        
        DispatchQueue.main.async {
            let url = URL(string: self.userImage.imageURL!)
            self.detailView.imageView.sd_setImage(with: url, completed: nil)
        }
    }
    
    private func setupView() {
        view.addSubview(detailView)
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.topAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    private func setNavigationItems() {
        let cancelButton =  UIBarButtonItem()
        cancelButton.action = #selector(cancelHandler)
        cancelButton.target = self
        cancelButton.tintColor = .mainColor
        cancelButton.icon(from: .fontAwesome, code: "timescircleo", ofSize: 25)
        
        
        let trashButton = UIBarButtonItem()
        trashButton.action = #selector(trashHandler)
        trashButton.target = self
        trashButton.tintColor = .mainColor
//        trashButton.width = 75
        trashButton.icon(from: .fontAwesome, code: "trasho", ofSize: 25)
        
        
        let downloadButton = UIBarButtonItem()
        downloadButton.action = #selector(downloadHandler)
        downloadButton.target = self
        downloadButton.tintColor = .mainColor
        downloadButton.icon(from: .fontAwesome, code: "download", ofSize: 25)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = 40
        
        navigationItem.rightBarButtonItems = [cancelButton, spacer ,trashButton, spacer, downloadButton]
    }
    @objc private func cancelHandler() {
        self.dismiss(animated: true, completion: nil)
    }
    @objc private func trashHandler() {
        
    }
    @objc private func downloadHandler() {
        
    }
}



