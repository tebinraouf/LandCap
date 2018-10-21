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
        setDetails()
    }
    private func setDetails() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = self.userImage.name
        
        DispatchQueue.main.async {
            let url = URL(string: self.userImage.imageURL!)
            self.detailView.imageView.sd_setImage(with: url, completed: { (image, error, cachedType, imageURL) in
                guard let image = image else { return }
                self.detailView.imageView.image = image
            })
            if let text = self.userImage.text {
                self.detailView.imageText.text = text
            }
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
        

        let shareButton =  UIBarButtonItem()
        shareButton.action = #selector(shareHandler)
        shareButton.target = self
        shareButton.tintColor = .mainColor
        shareButton.icon(from: .fontAwesome, code: "sharesquareo", ofSize: 25)
        
        
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
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        spacer.width = 40

        navigationItem.leftBarButtonItem = trashButton
        navigationItem.rightBarButtonItem = cancelButton
        
//        setToolbarItems(, animated: true)
        
        self.navigationController?.isToolbarHidden = false
        setToolbarItems([shareButton, spacer, downloadButton], animated: true)
        
    }
    @objc private func cancelHandler() {
        self.dismiss(animated: true, completion: nil)
    }
    @objc private func shareHandler() {
        
    }
    @objc private func trashHandler() {
        
    }
    @objc private func downloadHandler() {
        
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        detailView.imageText.setContentOffset(.zero, animated: true)
        detailView.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        detailView.textViewDidChange(detailView.imageText)
    }
}



