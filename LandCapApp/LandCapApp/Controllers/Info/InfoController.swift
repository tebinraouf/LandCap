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
        }
        
        
        func viewDidLayoutSubviews() {
            print("hi...")
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

extension InfoController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return infoModel.wikiModel.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.InfoCell, for: indexPath) as! InfoCell

        cell.wikiTextView.text = infoModel?.wikiModel[indexPath.row].text
        cell.textViewDidChange(cell.wikiTextView)
        cell.didCellTap = {
            self.handleCellTap(cell, indexPath)
        }

        if selected[indexPath.row] != nil {
            cell.wikiTextView.backgroundColor = .mainColor
            cell.wikiTextView.textColor = .white
        }
        else {
            cell.wikiTextView.backgroundColor = .white
            cell.wikiTextView.textColor = .black
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cell = InfoCell()
        cell.wikiTextView.text = infoModel.wikiModel[indexPath.row].text
        let estimatedSize = cell.wikiTextView.sizeThatFits(CGSize(width: view.frame.width, height: .infinity))
        cell.textViewDidChange(cell.wikiTextView)

        let size = CGSize(width: collectionView.frame.width, height: estimatedSize.height)
        return size
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    func handleCellTap(_ cell: InfoCell, _ indexPath: IndexPath) {
        let wikiModel = self.infoModel.wikiModel[indexPath.row]
        let count = self.selected.count
        
        
        if  self.selected[indexPath.row] == nil {
            if count < 3 {
                cell.wikiTextView.backgroundColor = .mainColor
                cell.wikiTextView.textColor = .white
                self.selected[indexPath.row] = wikiModel
            }
            else {
                alert(title: App.label.wikiAlertTitle, message: App.label.wikiAlertMessage, viewController: self)
            }
        }
        else {
            cell.wikiTextView.backgroundColor = .white
            cell.wikiTextView.textColor = .black
            self.selected[indexPath.row] = nil
        }
    }
    
}








