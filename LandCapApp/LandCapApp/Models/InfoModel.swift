//
//  InfoModel.swift
//  LandCapApp
//
//  Created by Tebin on 10/12/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import UIKit
import SwiftyJSON

struct WikiContentModel {
    var text: String
    var isSelected: Bool
}

struct InfoModel {
    var title: String?
    var confidence: String?
    var image: UIImage?
    var wikiModel: [WikiContentModel]
    var selectedWiki: Dictionary<Int, WikiContentModel>
    
    var selectedWikiTextCount: Int {
        return wikiModel.filter({$0.isSelected == true}).count
    }
    public init(image: UIImage?, title: String?, confidence: String?) {
        self.image = image
        self.title = title
        self.confidence = confidence
        wikiModel = []
        selectedWiki = Dictionary<Int, WikiContentModel>()
    }
}


struct WikiModel {
    var baseUrl: String = "https://en.wikipedia.org/w/api.php?action=query&prop=extracts&format=json&exintro=&titles="
    
    public init(_ title: String) {
        baseUrl += title
    }
    public func getWikiContent(_ callback: @escaping ([WikiContentModel])->()) {
        var all = [WikiContentModel]()
        parse { (content) in
            let results = self.linguisticTag(content)
            for text in results {
                let model = WikiContentModel(text: text, isSelected: false)
                all.append(model)
            }
            callback(all)
        }
    }
    private func parse(_ callback: @escaping (String)->()) {
        let session = URLSession.shared
        guard let url = URL(string: baseUrl) else { return }
        session.dataTask(with: url) { (data, response, e) in
            guard let data = data else { return }
            do {
                let json = try JSON(data: data)
                for (_,subJson):(String, JSON) in json["query"]["pages"] {
                    let html = Data(subJson["extract"].string!.utf8)
                    if let attributedString = try? NSAttributedString(data: html, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                        callback(attributedString.string.replacingOccurrences(of: "\n", with: ""))
                    }
                    break
                }
            }
            catch {
                print(error)
            }
        }.resume()
    }
    private func linguisticTag(_ text: String) -> [String] {
        var r = [Range<String.Index>]()
        let t = text.linguisticTags(
            in: text.startIndex..<text.endIndex,
            scheme: NSLinguisticTagScheme.lexicalClass.rawValue,
            tokenRanges: &r)
        var result = [String]()
        let ixs = t.enumerated().filter {
            $0.1 == "SentenceTerminator"
            }.map {r[$0.0].lowerBound}
        var prev = text.startIndex
        for ix in ixs {
            let r = prev...ix
            result.append(
                text[r].trimmingCharacters(
                    in: NSCharacterSet.whitespaces))
            prev = text.index(after: ix)
        }
        return result
    }
}
