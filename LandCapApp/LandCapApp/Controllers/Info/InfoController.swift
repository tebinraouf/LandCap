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
    var infoModel: InfoModel!
    var selected = Dictionary<Int, WikiContentModel>()
    
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
        /*
        if let landmark = landmarks.first?.landmark, let confidence = landmarks.first?.confidence {
            let roundConfidence = round(confidence.doubleValue * 100.0)
            infoModel = InfoModel(image: processedImage, title: landmark, confidence: roundConfidence)

            let wikiModel = WikiModel(landmark.replacingOccurrences(of: " ", with: "%20"))
            wikiModel.getWikiContent { (wikiContents) in
                DispatchQueue.main.async {
                    self.infoModel.wikiModel = wikiContents
                    self.infoView.infoModel = self.infoModel
                    self.infoView.wikiCollectionView.reloadData()
                }
            }
        */
        infoModel = InfoModel(image: UIImage(named: "statue.png")!, title: "Statue of Liberty Statue Liberty Statue", confidence: 20)
        let wikiModel = WikiModel("Statue of Liberty")
        wikiModel.getWikiContent { (wikiContents) in
            DispatchQueue.main.async {
                self.infoModel.wikiModel = wikiContents
                self.infoView.infoModel = self.infoModel
                self.infoView.wikiCollectionView.reloadData()
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.infoView.wikiCollectionView.reloadData()
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
        print(selected)
    }
    @objc private func cancelHandler() {
        //Back to the Camera
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}










