//
//  Page.swift
//  LandCapApp
//
//  Created by Tebin on 9/10/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import UIKit

///Page Model for PageController
struct Page {
    ///Page title
    var title: String?
    ///Page description
    var description: String?
    ///Page image
    var image: UIImage?
    
    private let firstPageName = NSLocalizedString("Building", comment: "Building")
    private let secondPageName = NSLocalizedString("Knowledge", comment: "Knowledge")
    private let thirdPageName = NSLocalizedString("Geocode", comment: "Geocode")
    
    private let firstPageDesc = NSLocalizedString("Building Desc", comment: "Building Page Description")
    private let secondPageDesc = NSLocalizedString("Knowledge Desc", comment: "Knowledge Page Description")
    private let thirdPageDesc = NSLocalizedString("Geocode Desc", comment: "Geocode Page Description")
    
    
    ///Empty init
    init() {
        //empty constructor
    }
    ///Initialize a page
    /// - Parameter title: page title
    /// - Parameter description: page description
    /// - Parameter image: page image
    ///
    init(title: String, description: String, image: UIImage) {
        self.title = title
        self.description = description
        self.image = image
    }
    ///Get predefined pages
    ///
    /// - Returns: an array of `Page`
    func getPages() -> [Page] {
        let pages: [Page] = {
            let firstPage = Page(title: firstPageName, description: firstPageDesc, image: #imageLiteral(resourceName: "building"))
            let secondPage = Page(title: secondPageName, description: secondPageDesc, image: #imageLiteral(resourceName: "info"))
            let thirdPage = Page(title: thirdPageName, description: thirdPageDesc, image: #imageLiteral(resourceName: "geocode"))
            return [firstPage, secondPage, thirdPage]
        }()
        return pages;
    }
}


