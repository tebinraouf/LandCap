//
//  CollectionDelegate.swift
//  LandCapApp
//
//  Created by Tebin on 9/16/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import Foundation
import UIKit

extension PageController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    ///numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count + 1
    }
    ///cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.PageCell, for: indexPath) as! PageCell
        
        if indexPath.item != 3 {
            cell.page = pages[indexPath.item]
        }
        return cell
    }
    ///collectionViewLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.width, height: collectionView.frame.height - 44)
        return size
    }
    ///collectionViewLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    ///forItemAt
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as! PageCell
        //handle cell UI
        if indexPath.item == pages.count {
            isLoginPage(true, cell)
            cell.loginView = pageView.loginView
        }else {
            isLoginPage(false, cell)
        }
    }
    ///scrollViewWillEndDragging
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        pageView.currentPage = pageNumber
        prepareLoginPage(pageNumber)
    }
    ///prepareLoginPage
    func prepareLoginPage(_ pageNumber: Int){
        if pageNumber == pages.count {
            pageView.updateConstraintFor(getStarted: -300, skip: -20, pageControl: -300, loginView: 0, socialLoginBtn: 0)
        } else {
            pageView.updateConstraintFor(getStarted: 0, skip: 100, pageControl: 0, loginView: 400, socialLoginBtn: 400)
        }
    }
    ///isLoginPage
    func isLoginPage(_ bool: Bool, _ cell: PageCell){
        cell.imageView.isHidden = bool
        cell.descriptionLabel.isHidden = bool
        cell.titleLabel.isHidden = bool
    }
}
