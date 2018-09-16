//
//  PageController.swift
//  LandCapApp
//
//  Created by Tebin on 9/10/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import UIKit

class PageController: UIViewController {
    
    let pages : [Page] = {
        let page = Page()
        return page.getPages()
    }()
    
    let pageView = PageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print("PageController")
        
        setupView()
        setDelegates()
    }
    
    func setupView(){
        view.addSubview(pageView)
        NSLayoutConstraint.activate([
            pageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageView.topAnchor.constraint(equalTo: view.topAnchor),
            pageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    func setDelegates(){
        pageView.collectionViewDelegate = self
        pageView.collectionViewDataSource = self
        pageView.loginDelegate = self
        pageView.setTextFieldsDelegate(self)
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}

extension PageController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count + 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.PageCell, for: indexPath) as! PageCell
        
        if indexPath.item != 3 {
            cell.page = pages[indexPath.item]
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.width, height: collectionView.frame.height - 44)
        return size
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
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
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        pageView.currentPage = pageNumber
        prepareLoginPage(pageNumber)
    }
    func prepareLoginPage(_ pageNumber: Int){
        if pageNumber == pages.count {
            pageView.updateConstraintFor(getStarted: -300, pageControl: -300, loginView: 0, facebookBtn: 0)
        } else {
            pageView.updateConstraintFor(getStarted: 0, pageControl: 0, loginView: 400, facebookBtn: 400)
        }
    }
    func isLoginPage(_ bool: Bool, _ cell: PageCell){
        cell.imageView.isHidden = bool
        cell.descriptionLabel.isHidden = bool
        cell.titleLabel.isHidden = bool
    }
}

extension PageController: LoginViewDelegate {
    func signInBtn(email: String?, password: String?) {
        print("Email: \(email), password: \(password)")
    }
    
    func registerBtn(name: String?, email: String?, password: String?) {
        print("Name: \(name), email: \(email), password: \(password)")
    }
    
    func signInBtn() {
        print("loginBtn")
    }
    
    func forgetPasswordBtn() {
        print("forgetPasswordBtn")
    }
    
    func getStartedBtn() {
        let indexPath = IndexPath(item: 3, section: 0)
        pageView.pageCollectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.left, animated: true)
        pageView.updateConstraintFor(getStarted: -300, pageControl: -300, loginView: 0, facebookBtn: 0)
    }
    
}

extension PageController: UITextFieldDelegate {
    //MARK: Handle Keyboard Dismissal
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        pageView.keyboardResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pageView.keyboardResponder()
        return true
    }
}
