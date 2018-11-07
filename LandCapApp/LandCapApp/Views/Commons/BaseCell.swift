//
//  BaseCell.swift
//  LandCapApp
//
//  Created by Tebin on 9/10/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import UIKit
///A utility class derived from UICollectionViewCell for all UICollectionView cells
class BaseCell: UICollectionViewCell {
    ///Main constructor
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    ///A starting point for all classes that use `BaseCell` as the base class.
    func setupView() {
        //setup views here
    }
    ///Required for UICollectionViewCell
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
