//
//  BaseView.swift
//  LandCapApp
//
//  Created by Tebin on 9/10/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import UIKit
///A utility class derived from UIView for all UIView cells
class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    ///A starting point for all classes that use `BaseView` as the base class.
    func setupView() {
        //to be overridden by child classes
    }
    ///Required for UIView
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
