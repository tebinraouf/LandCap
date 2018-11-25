//
//  InfoCell.swift
//  LandCapApp
//
//  Created by Tebin on 10/12/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import UIKit
import SwiftIconFont
///The InfoController UICollectionView Cell view
class InfoCell: BaseCell {
    
    ///The wikipedia text view
    public var wikiTextView: UITextView = {
        let tv = UITextView()
        tv.text = "Testing...."
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .white
        tv.isEditable = false
        tv.textAlignment = .left
        tv.isScrollEnabled = true
        tv.layer.cornerRadius = 20
        tv.layer.borderWidth = 0.5
        tv.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tv.layer.borderColor = UIColor.lightGray.cgColor
        tv.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        tv.isSelectable = false
        return tv
    }()
    ///Initial cell setup
    override func setupView() {
        backgroundColor = .clear
        textViewSetup()
    }
    private func textViewSetup() {
        addSubview(wikiTextView)
        NSLayoutConstraint.activate([
            wikiTextView.topAnchor.constraint(equalTo: topAnchor),
            wikiTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            wikiTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            wikiTextView.heightAnchor.constraint(equalToConstant: 100)
            ])
//        wikiTextView.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleWikiTextTap))
        wikiTextView.addGestureRecognizer(tap)
    }
    ///A callback function to handle `wikiTextView` textview
    public var didCellTap: (()->())?
    @objc private func handleWikiTextTap() {
        didCellTap?()
    }
}

