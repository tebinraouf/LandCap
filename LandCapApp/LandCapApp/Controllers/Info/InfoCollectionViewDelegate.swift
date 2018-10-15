//
//  InfoCollectionViewDelegate.swift
//  LandCapApp
//
//  Created by Tebin on 10/14/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import UIKit

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
            if count < 5 {
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
