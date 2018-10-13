//
//  InfoModel.swift
//  LandCapApp
//
//  Created by Tebin on 10/12/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import UIKit

struct WikiContentModel {
    var text: String
    var isSelected: Bool
}

struct InfoModel {
    var title: String?
    var confidence: String?
    var image: UIImage?
    var wikiModel: [WikiContentModel]
    public init(image: UIImage?, title: String?, confidence: String?) {
        self.image = image
        self.title = title
        self.confidence = confidence
        wikiModel = []
    }
}
