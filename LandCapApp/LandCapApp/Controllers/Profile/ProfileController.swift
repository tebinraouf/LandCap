//
//  ProfileController.swift
//  LandCapApp
//
//  Created by Tebin on 9/26/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import Foundation
import UIKit
import FirebaseUI

class ProfileController: UIViewController {
    
    var profileView = ProfileView()
    var capDatabase: CapDatabase!
    var userImageObjects = [UserImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ProfileController")
        
        setupView()
        setNavigationItems()
        setupDelegate()
        
//        getImages()
        //testData()
    }
    private func testData() {
        var testImage = UserImage()
        testImage.imageURL = "https://www.nps.gov/common/uploads/grid_builder/ner/crop16_9/89721987-1DD8-B71B-0BE77EEAE39E0520.jpg?width=950&quality=90&mode=crop"
        testImage.text = "This is my text. This is test...."
        userImageObjects.append(testImage)
        
        testImage.imageURL = "https://images-na.ssl-images-amazon.com/images/I/615StV0ULHL._SY679_.jpg"
        testImage.text = "This is a nice picture of Eiffel Tower....."
        userImageObjects.append(testImage)
        
        testImage.imageURL = "https://img.jakpost.net/c/2017/02/10/2017_02_10_21340_1486708892._large.jpg"
        testImage.text = "Another nice picture....dummy text...."
        userImageObjects.append(testImage)
    }
    override func viewDidLayoutSubviews() {
        self.profileView.imageCollectionView.reloadData()
    }
    private func setupView() {
        view.addSubview(profileView)
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: view.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    private func setupDelegate() {
        profileView.collectionViewDataSource = self
        profileView.collectionViewDelegate = self
    }
    private func setNavigationItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: UIBarButtonItemStyle.done, target: self, action: #selector(handleSignOut))
    }
    private func getImages() {
        capDatabase = CapDatabase(userID: User.session.currentUserID)
        DispatchQueue.main.async {
            self.capDatabase.getImages { (userImage) in
                self.userImageObjects.append(userImage)
                self.profileView.imageCollectionView.reloadData()
            }
        }
    }
    @objc func handleSignOut() {
        User.session.isSignedIn = false
        let navigationController = UINavigationController(rootViewController: PageController())
        present(navigationController, animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.userImageObjects.removeAll()
        getImages()
        profileView.imageCollectionView.reloadData()
    }
}

extension ProfileController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userImageObjects.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.ProfileCell, for: indexPath) as! ProfileCell
        DispatchQueue.main.async {
            let url = URL(string: self.userImageObjects[indexPath.row].imageURL!)
            cell.imageView.sd_setImage(with: url, completed: { (image, error, cachedType, imageURL) in
                guard let image = image else { return }
                cell.imageView.image = image.cropToBounds(width: 100, height: 100)
            })
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = profileView.imageCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        layout.invalidateLayout()
        return CGSize(width: ((self.view.frame.width/3) - 1), height:((self.view.frame.width / 3) - 1));
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = DetailController()
        detailController.userImage = userImageObjects[indexPath.row]
        let navController = UINavigationController(rootViewController: detailController)
        self.present(navController, animated: true, completion: nil)
    }
    
}
