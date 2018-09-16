//
//  PageView.swift
//  LandCapApp
//
//  Created by Tebin on 9/10/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import UIKit

class PageView: BaseView {
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isPagingEnabled = true
        return cv
    }()
    var logoLabel: UILabel = {
        let label = UILabel()
        label.text = "LandCap"
        label.tintColor = .white
        label.textColor = .white
        label.backgroundColor = .clear
        label.font = UIFont(name: "Iowan Old Style", size: 70)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = .lightGray
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.numberOfPages = 4 //self.pages.count + 1
        pc.currentPageIndicatorTintColor = .orange
        return pc
    }()
    var getStartedButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("GET STARTED", for: .normal)
        btn.backgroundColor = .orange
        btn.tintColor = .white
        btn.layer.cornerRadius = 20
        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        btn.addTarget(self, action: #selector(handleGetStarted), for: .touchDown)
        return btn
    }()
    override func setupView() {
        collectionViewSetup()
        logoLabelViewSetup()
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: CellID.PageCell)
        setupPageControl()
        setupGetStartedButton()
    }
    func collectionViewSetup() {
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: -44),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -150)
            ])
    }
    func logoLabelViewSetup() {
        addSubview(logoLabel)
        NSLayoutConstraint.activate([
            logoLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            logoLabel.heightAnchor.constraint(equalTo: logoLabel.heightAnchor),
            logoLabel.widthAnchor.constraint(equalTo: logoLabel.widthAnchor),
            logoLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
    }
    func setupPageControl() {
//        pageControlConstraint = pageControl.centerXAnchor.constraint(equalTo: getStartedBackground.centerXAnchor)
//        pageControlConstraint.isActive = true
        addSubview(pageControl)
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 30),
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.heightAnchor.constraint(equalTo: pageControl.heightAnchor),
            pageControl.widthAnchor.constraint(equalTo: pageControl.widthAnchor),
            ])
    }
    func setupGetStartedButton() {
//        getStartedConstraint = getStartedButton.centerXAnchor.constraint(equalTo: getStartedBackground.centerXAnchor)
//        getStartedConstraint.isActive = true
        addSubview(getStartedButton)
        NSLayoutConstraint.activate(
            [getStartedButton.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 15),
             getStartedButton.heightAnchor.constraint(equalTo: getStartedButton.heightAnchor),
             getStartedButton.widthAnchor.constraint(equalTo: getStartedButton.widthAnchor),
             getStartedButton.centerXAnchor.constraint(equalTo: centerXAnchor),
             ])
    }
    @objc func handleGetStarted() {
        print("get started....")
    }
}


extension PageView {
    var collectionViewDelegate: UICollectionViewDelegate? {
        get {
            return collectionView.delegate
        }
        set {
            collectionView.delegate = newValue
        }
    }
    var collectionViewDataSource: UICollectionViewDataSource? {
        get {
            return collectionView.dataSource
        }
        set {
            collectionView.dataSource = newValue
        }
    }
    var currentPage: Int {
        get {
            return pageControl.currentPage
        }
        set {
            pageControl.currentPage = newValue
        }
    }
}




