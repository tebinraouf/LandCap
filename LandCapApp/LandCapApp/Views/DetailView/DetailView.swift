//
//  DetailView.swift
//  LandCapApp
//
//  Created by Tebin on 10/18/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import UIKit

class DetailView: BaseView {
    
    
    public var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    
    public var imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .blue
        return iv
    }()
    public var imageText: UITextView = {
        let tv = UITextView()
        tv.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .mainLightGray
        tv.isEditable = false
        tv.textAlignment = .left
        tv.isScrollEnabled = true
        tv.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tv.layer.borderColor = UIColor.lightGray.cgColor
        tv.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        tv.isSelectable = false
        tv.setContentOffset(CGPoint.zero, animated: true)
        return tv
    }()
    
    override func setupView() {
        backgroundColor = .mainLightGray
        
        scrollSetup()
        scrollView.addSubview(imageView)
        
        imageSetup()
        textViewSetup()
    }
    private func scrollSetup() {
        scrollView.showsVerticalScrollIndicator = true
        scrollView.isUserInteractionEnabled = true
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        
    }
    
    private func imageSetup() {
        scrollView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            imageView.heightAnchor.constraint(equalToConstant: 500)
            ])
    }
    private func textViewSetup() {
        scrollView.addSubview(imageText)
        NSLayoutConstraint.activate([
            imageText.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            imageText.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            imageText.heightAnchor.constraint(equalToConstant: 150),
            ])
    }
}

extension DetailView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: frame.width, height: CGFloat.infinity)
        let estimatedSize = textView.sizeThatFits(size)
        imageText.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
}

