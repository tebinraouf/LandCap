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
    var processedImage: UIImage!
    
    var infoView: InfoView = InfoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print("InfoController")
        setupView()
        setNavigationItems()
        setupModel()
        setupDelegate()
    }
    
    private func setupView() {
        view.addSubview(infoView)
        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: view.topAnchor),
            infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            infoView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    private func setupModel() {
        let infoModel = InfoModel(image: UIImage(named: "statue.png"), title: "Statue", confidence: "12%")
//        let infoModel = InfoModel(image: processedImage, title: "Statue", confidence: "12%")
        infoView.infoModel = infoModel
    }
    private func setupDelegate() {
        infoView.collectionViewDataSource = self
        infoView.collectionViewDelegate = self
    }
    
    private func setNavigationItems() {
        navigationItem.rightBarButtonItem =  UIBarButtonItem(title: App.label.cancelInfo, style: .plain, target: self, action: #selector(cancelHandler))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: App.label.saveInfo, style: .plain, target: self, action: #selector(saveHandler))
    }
}

extension InfoController {
    @objc private func saveHandler() {
        print("save photo...")
    }
    @objc private func cancelHandler() {
        //Back to the Camera
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

extension InfoController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.InfoCell, for: indexPath) as! InfoCell
        
        cell.backgroundColor = .red
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.width, height: 200)
        return size
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}
