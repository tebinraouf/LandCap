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

///InforController to show a processed photo
class InfoController: UIViewController {
    
    ///The list of landmarks returns from the Vision API
    public var landmarks: [VisionCloudLandmark]!
    
    ///The taken image data
    public var imageData: Data!

    ///The HomeController instance to go back after saving the photo
    public weak var homeController: HomeController!

    ///The landmark name
    private var landmarkName: String!
    
    private var infoView: InfoView!
    ///The `InfoModel` instance of the controller
    public var infoModel: InfoModel!
    
    ///Hold the user selected texts
    public var selected = Dictionary<Int, WikiContentModel>()
    
    ///Initial load
    override func viewDidLoad() {
        super.viewDidLoad()
        print("InfoController")
        setupView()
        setNavigationItems()
//        setupModel()
        testData()
        setupDelegate()
    }
    private func setupView() {
        infoView = InfoView()
        infoView.delegate = self
        view.addSubview(infoView)
        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: view.topAnchor),
            infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            infoView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    private func calculateTopDistance() -> CGFloat {
        guard let navigationHeight = self.navigationController?.navigationBar.frame.height else {return 0}
        let statusHeight = UIApplication.shared.statusBarFrame.height
        return navigationHeight + statusHeight
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
    private func testData() {
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
    ///viewWillAppear
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



///Handle InfoView Delegate
extension InfoController: InfoViewDelegate {
    var topDistance: CGFloat {
        return calculateTopDistance()
    }
}






