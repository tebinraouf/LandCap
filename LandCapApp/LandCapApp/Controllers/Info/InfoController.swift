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
        infoModel = InfoModel(image: UIImage(named: "statue.png"), title: "Statue", confidence: "12%")
        
        let model = WikiContentModel(text: "The Statue of Liberty (Liberty Enlightening the World; French: La Liberté éclairant le monde) is a colossal neoclassical sculpture on Liberty Island in New York Harbor in New York City, in the United States", isSelected: false)
        let model2 = WikiContentModel(text: "The copper statue, a gift from the people of France to the people of the United States, was designed by French sculptor Frédéric Auguste Bartholdi and built by Gustave Eiffel. The Statue of Liberty (Liberty Enlightening the World; French: La Liberté éclairant le monde) is a colossal neoclassical sculpture on Liberty Island in New York Harbor in New York City, in the United States.", isSelected: false)
        let model3 = WikiContentModel(text: "The Statue of Liberty (Liberty Enlightening the World; French: La Liberté éclairant le monde) is a colossal neoclassical sculpture on Liberty Island in New York Harbor in New York City, in the United States", isSelected: false)
        
        infoModel.wikiModel = [model, model2, model3]
        
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
        return infoModel.wikiModel.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.InfoCell, for: indexPath) as! InfoCell

        cell.wikiTextView.text = infoModel?.wikiModel[indexPath.row].text
        cell.textViewDidChange(cell.wikiTextView)
        
        cell.didCellTap = {
            self.handleCellTap(cell, indexPath)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cell = InfoCell()
        cell.wikiTextView.text = infoModel.wikiModel[indexPath.row].text
        let estimatedSize = cell.wikiTextView.sizeThatFits(CGSize(width: view.frame.width, height: .infinity))
        
        
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
        if !wikiModel.isSelected {
            if (self.infoModel.selectedWikiTextCount < 2) {
                cell.wikiTextView.backgroundColor = .mainColor
                cell.wikiTextView.textColor = .white
                self.infoModel.wikiModel[indexPath.row].isSelected = true
            }
            else {
                alert(title: App.label.wikiAlertTitle, message: App.label.wikiAlertMessage, viewController: self)
            }
        }
        else {
            cell.wikiTextView.backgroundColor = .white
            cell.wikiTextView.textColor = .black
            self.infoModel?.wikiModel[indexPath.row].isSelected = false
        }
    }
    
}
