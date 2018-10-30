//
//  InfoController.swift
//  LandCapApp
//
//  Created by Tebin on 10/12/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import UIKit
import Firebase
import CDAlertView

class InfoController: UIViewController {
    
    var landmarks: [VisionCloudLandmark]!
    var landmarkName: String!
    var imageData: Data!
    weak var homeController: HomeController!
    
    var infoView: InfoView = InfoView()
    var infoModel: InfoModel!
    var selected = Dictionary<Int, WikiContentModel>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("InfoController")
        setupView()
        setNavigationItems()
        setupModel()
//        testData()
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
        infoView.spinner.startAnimating()
        if let landmark = landmarks.first?.landmark, let confidence = landmarks.first?.confidence {
            let roundConfidence = round(confidence.doubleValue * 100.0)
            infoModel = InfoModel(image: UIImage(data: imageData), title: landmark, confidence: roundConfidence)
            let wikiModel = WikiModel(landmark)
            landmarkName = landmark
            wikiModel.getWikiContent { (wikiContents) in
                DispatchQueue.main.async {
                    self.infoModel.wikiModel = wikiContents
                    self.infoView.infoModel = self.infoModel
                    self.infoView.wikiCollectionView.reloadData()
                    self.infoView.imageViewIsHidden = false
                    self.infoView.spinner.stopAnimating()
                }
            }
        }
    }
    func testData() {
        infoModel = InfoModel(image: UIImage(named: "statue.png")!, title: "Statue of Liberty Statue Liberty Statue", confidence: 20)
        let wikiModel = WikiModel("Staten Island Ferry")
        wikiModel.getWikiContent { (wikiContents) in
            DispatchQueue.main.async {
                self.infoModel.wikiModel = wikiContents
                self.infoView.infoModel = self.infoModel
                self.infoView.wikiCollectionView.reloadData()
                self.infoView.imageViewIsHidden = false
                self.infoView.spinner.stopAnimating()
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
        
        if User.session.isAnonymous {
            let alert = CDAlertView(title: App.label.wikiSaveGuestTitle, message: App.label.wikiSaveGuestMessage, type: .warning)
            alert.show()
        }
        else {
            //initial setup
            infoView.spinner.startAnimating()
            navigationItem.rightBarButtonItem?.isEnabled = false
            navigationItem.leftBarButtonItem?.isEnabled = false
            
            let userID = User.session.currentUserID
            let capDatabase = CapDatabase(userID: userID)
            capDatabase.addNew(image: imageData, with: userSelectedText(), with: landmarkName) {
                self.infoView.spinner.stopAnimating()
                self.handleAlert()
            }
        }
    }
    private func userSelectedText() -> String {
        let sortedText = selected.sorted(by: {$0.key < $1.key })
        var text = ""
        for (_,value) in sortedText {
            text += value.text
            text += " "
        }
        return text
    }
    private func handleAlert() {
        let alert = CDAlertView(title: App.label.wikiFirebaseAlertTitle, message: App.label.wikiFirebaseAlertMessage, type: .success)
        let profile = CDAlertViewAction(title: App.label.wikiFirebaseAlertProfileBtn, font: nil, textColor: .mainColor, backgroundColor: nil, handler: { (action) -> Bool in
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: {
                let profile = ProfileController()
                self.homeController.navigationController?.pushViewController(profile, animated: true)
            })
            return true
        })
        let morePhotos = CDAlertViewAction(title: App.label.wikiFirebaseAlertHomeBtn, font: nil, textColor: .mainColor, backgroundColor: nil, handler: { (action) -> Bool in
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            return true
        })
        alert.add(action: profile)
        alert.add(action: morePhotos)
        alert.show()
    }
    @objc private func cancelHandler() {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}










