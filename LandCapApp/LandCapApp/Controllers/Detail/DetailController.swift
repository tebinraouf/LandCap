//
//  DetailController.swift
//  LandCapApp
//
//  Created by Tebin on 10/17/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import UIKit
import FirebaseUI
import CDAlertView

class DetailController: UIViewController {
    
    public var userImage: UserImage!
    
    private var detailView = DetailView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setNavigationItems()
        setDetails()
        
        
        
        
        
        print("hello")
        
        
    }
    private func setDetails() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = self.userImage.name
        
        DispatchQueue.main.async {
            let url = URL(string: self.userImage.imageURL!)
            self.detailView.imageView.sd_setImage(with: url, completed: { (image, error, cachedType, imageURL) in
                guard let image = image else { return }
                self.detailView.imageView.image = image
            })
            if let text = self.userImage.text {
                self.detailView.imageText.text = text
            }
        }
    }
    private func setupView() {
        view.addSubview(detailView)
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.topAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    private func setNavigationItems() {
        let cancelButton =  UIBarButtonItem()
        cancelButton.action = #selector(cancelHandler)
        cancelButton.target = self
        cancelButton.tintColor = .mainColor
        cancelButton.icon(from: .fontAwesome, code: "timescircleo", ofSize: 25)
        

        let shareButton =  UIBarButtonItem()
        shareButton.action = #selector(shareHandler)
        shareButton.target = self
        shareButton.tintColor = .mainColor
        shareButton.icon(from: .fontAwesome, code: "sharesquareo", ofSize: 25)
        
        
        let trashButton = UIBarButtonItem()
        trashButton.action = #selector(trashHandler)
        trashButton.target = self
        trashButton.tintColor = .mainColor
        trashButton.icon(from: .fontAwesome, code: "trasho", ofSize: 25)
        
        
        let downloadButton = UIBarButtonItem()
        downloadButton.action = #selector(downloadHandler)
        downloadButton.target = self
        downloadButton.tintColor = .mainColor
        downloadButton.icon(from: .fontAwesome, code: "download", ofSize: 25)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        navigationItem.leftBarButtonItem = trashButton
        navigationItem.rightBarButtonItem = cancelButton
        
        self.navigationController?.isToolbarHidden = false
        setToolbarItems([shareButton, spacer, downloadButton], animated: true)
    }
    @objc private func cancelHandler() {
        self.dismiss(animated: true, completion: nil)
    }
    @objc private func shareHandler() {
        
    }
    @objc private func trashHandler() {
        handleAlert {
            let database = CapDatabase(userID: User.session.currentUserID)
            database.deleteUserImage(userImage: self.userImage)
            self.dismiss(animated: true, completion: nil)
        }
        print("deleted...")
    }
    @objc private func downloadHandler() {
        let image = textToImage(drawText: self.detailView.imageText.text, inImage: self.detailView.imageView.image!, atPoint: CGPoint(x: 0, y: 0))
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveImage(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        detailView.textViewDidChange(detailView.imageText)
        detailView.imageText.setContentOffset(.zero, animated: true)
        
        let size = CGSize(width: detailView.frame.width, height: CGFloat.infinity)
        let estimatedSize = detailView.imageText.sizeThatFits(size)
        //500 is the height of the image
        detailView.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: estimatedSize.height + 500)
    }
    private func handleAlert(_ callback: @escaping ()->()) {
        let alert = CDAlertView(title: App.label.detailsAlertTitle, message: App.label.detailsAlertMessage, type: .warning)
        let cancel = CDAlertViewAction(title: App.label.detailsAlertCancelBtn, font: nil, textColor: .mainColor, backgroundColor: nil, handler: nil)
        let delete = CDAlertViewAction(title: App.label.detailsAlertAcceptBtn, font: nil, textColor: .mainColor, backgroundColor: nil, handler: { (action) -> Bool in
            callback()
            return true
        })
        alert.add(action: cancel)
        alert.add(action: delete)
        alert.show()
    }
    func textToImage(drawText text: String, inImage image: UIImage, atPoint point: CGPoint) -> UIImage {
        let textColor = UIColor.blackColor
        let textBackground = UIColor(r: 240, g: 240, b: 240, a: 0.8)
        let textFont = UIFont(name: "Helvetica Bold", size: 50)!
        
        let scale = UIScreen.main.scale
        //TODO: this is not a good solution and it doesn't work well.
        let originalImageSize = image.size
        var height: CGFloat = 300
        if text.count > 600 && text.count < 1000 {
            height = 600
        } else if text.count > 1000 {
            height = 700
        }
        
        let size = CGSize(width: originalImageSize.width, height: originalImageSize.height + height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        
        let textFontAttributes = [
            NSAttributedStringKey.font: textFont,
            NSAttributedStringKey.backgroundColor: textBackground,
            NSAttributedStringKey.foregroundColor: textColor,
            ] as [NSAttributedStringKey : Any]
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        
        let rect = CGRect(origin: CGPoint(x: 0, y: image.size.height), size: size)
        text.draw(in: rect, withAttributes: textFontAttributes)
        print(text.count)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    @objc func saveImage(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
}
