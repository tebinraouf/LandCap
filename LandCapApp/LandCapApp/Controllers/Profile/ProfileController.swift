//
//  ProfileController.swift
//  LandCapApp
//
//  Created by Tebin on 9/26/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import UIKit
import AVFoundation
import FirebaseUI

///User ProfileController
class ProfileController: UIViewController {
    
    ///ProfileController View
    var profileView = ProfileView()
    
    ///Database instance
    var capDatabase: CapDatabase!
    
    ///Collection of user images
    var userImageObjects = [UserImage]()
    
    ///Initial load
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setNavigationItems()
        setupDelegate()
        getName()
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
    ///viewDidLayoutSubviews
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
        profileView.delegate = self
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
    private func getName() {
        capDatabase = CapDatabase(userID: User.session.currentUserID)
        DispatchQueue.main.async {
            self.capDatabase.getName({ (name, profileUrl) in
                self.profileView.userName = name
                self.profileView.imageView.sd_setImage(with: URL(string: profileUrl), completed: { (image, error, cachedType, imageURL) in
                    guard let image = image else { return }
                    self.profileView.imageView.image = image
                })
            })
        }
    }
    @objc private func handleSignOut() {
        User.session.isSignedIn = false
        let navigationController = UINavigationController(rootViewController: PageController())
        present(navigationController, animated: true, completion: nil)
    }
    ///viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.userImageObjects.removeAll()
        getImages()
        profileView.imageCollectionView.reloadData()
    }
}

extension ProfileController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    ///numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userImageObjects.count
    }
    ///cellForItemAt
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
    ///collectionViewLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = profileView.imageCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        layout.invalidateLayout()
        return CGSize(width: ((self.view.frame.width/3) - 1), height:((self.view.frame.width / 3) - 1));
    }
    ///minimumLineSpacingForSectionAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    ///minimumInteritemSpacingForSectionAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    ///insetForSectionAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    ///didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = DetailController()
        detailController.userImage = userImageObjects[indexPath.row]
        let navController = UINavigationController(rootViewController: detailController)
        self.present(navController, animated: true, completion: nil)
    }
    
}

extension ProfileController: ProfileDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    ///Profile image tap handler
    func handleProfileTap() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary //UIImagePickerController.SourceType.
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    ///handle image picker for profile
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true)
        let chosenImage = info[UIImagePickerControllerEditedImage] as? UIImage
        guard let image = chosenImage else { return }
        guard let imageData = UIImagePNGRepresentation(image) else { return }
        
        DispatchQueue.main.async {
            let capDatabase = CapDatabase(userID: User.session.currentUserID)
            capDatabase.updateProfileImage(imageData: imageData) { (imageUrl) in
                capDatabase.update(profileUrl: imageUrl)
            }
            self.profileView.imageView.image = UIImage(data: imageData)
        }
    }
}
