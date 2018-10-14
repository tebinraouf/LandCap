//
//  InfoCell.swift
//  LandCapApp
//
//  Created by Tebin on 10/12/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import UIKit
import SwiftIconFont

class InfoCell: BaseCell {
    public var wikiTextView: UITextView = {
        let tv = UITextView()
        tv.text = "Testing...."
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .white
        tv.isEditable = false
        tv.textAlignment = .left
        tv.isScrollEnabled = false
        tv.layer.cornerRadius = 20
        tv.layer.borderWidth = 0.5
        tv.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tv.layer.borderColor = UIColor.lightGray.cgColor
        tv.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        tv.isSelectable = false
        return tv
    }()
    var bookmarkButton: UIButton = {
        let btn = UIButton(type: UIButtonType.system)
        btn.titleLabel?.font = UIFont.icon(from: .fontAwesome, ofSize: 30)
//        btn.setTitle(String.fontAwesomeIcon("bookmarko"), for: UIControlState.normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.showsTouchWhenHighlighted = true
        btn.tintColor = .lightGray
        btn.backgroundColor = .clear
        return btn
    }()
    override func setupView() {
        backgroundColor = .clear
        textViewSetup()
        bookmarkButtonSetup()
    }
    private func textViewSetup() {
        addSubview(wikiTextView)
        NSLayoutConstraint.activate([
            wikiTextView.topAnchor.constraint(equalTo: topAnchor),
            wikiTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            wikiTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            wikiTextView.heightAnchor.constraint(equalToConstant: 150)
            ])
        wikiTextView.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleWikiTextTap))
        wikiTextView.addGestureRecognizer(tap)
        
        textViewDidChange(wikiTextView)
        wikiTextView.layoutIfNeeded()
    }
    private func bookmarkButtonSetup() {
        addSubview(bookmarkButton)
        NSLayoutConstraint.activate([
            bookmarkButton.topAnchor.constraint(equalTo: topAnchor, constant: -7),
            bookmarkButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 40),
            bookmarkButton.widthAnchor.constraint(equalToConstant: 40)
            ])
    }
    public var didCellTap: (()->())?
    @objc private func handleWikiTextTap() {
        didCellTap?()
    }
}

extension InfoCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: frame.width, height: CGFloat.infinity)
        let estimatedSize = textView.sizeThatFits(size)
        wikiTextView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
}
