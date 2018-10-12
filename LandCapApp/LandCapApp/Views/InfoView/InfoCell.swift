//
//  InfoCell.swift
//  LandCapApp
//
//  Created by Tebin on 10/12/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import UIKit

class InfoCell: BaseCell {
    private var textView: UITextView = {
        let tv = UITextView()
        tv.text = "Testing...."
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .white
        tv.isEditable = false
        tv.isSelectable = true
        return tv
    }()
    override func setupView() {
        textViewSetup()
    }
    private func textViewSetup() {
        addSubview(textView)
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: topAnchor),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            textView.heightAnchor.constraint(equalToConstant: 200)
            ])
    }
}
