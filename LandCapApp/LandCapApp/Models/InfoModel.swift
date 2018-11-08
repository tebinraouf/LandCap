//
//  InfoModel.swift
//  LandCapApp
//
//  Created by Tebin on 10/12/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import UIKit
import SwiftyJSON

///UserImage model
struct UserImage {
    ///Image text
    var text: String?
    ///Image name
    var name: String?
    ///Image url
    var imageURL: String?
    
    ///image ID
    var id: String?
    
    ///Empty init
    init() {
        
    }
}

extension UserImage: Equatable {
    ///UserImage Equatable
    static func == (lhs: UserImage, rhs: UserImage) -> Bool {
        return lhs.id == rhs.id
    }
}
extension UserImage: Hashable {
    ///UserImage Hashable
    var hashValue: Int {
        return id.hashValue
    }
}


///WikiContent Model
struct WikiContentModel {
    ///Wiki Text
    var text: String
    ///Wiki selected text
    var isSelected: Bool
}

///InfoController Model
struct InfoModel {
    ///Image title
    var title: String?
    ///Image recognized confidence level
    var confidence: Double?
    ///Image
    var image: UIImage?
    ///Wiki Content
    var wikiModel: [WikiContentModel]
    ///Selected wiki content
    var selectedWiki: Dictionary<Int, WikiContentModel>
    
    ///selectedWikiTextCount
    var selectedWikiTextCount: Int {
        return wikiModel.filter({$0.isSelected == true}).count
    }
    ///InfoModel init
    public init(image: UIImage?, title: String?, confidence: Double?) {
        self.image = image
        self.title = title
        self.confidence = confidence
        wikiModel = []
        selectedWiki = Dictionary<Int, WikiContentModel>()
    }
}

///InfoController model
struct WikiModel {
    private var baseUrl: String = "https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro&explaintext&redirects=1&titles="
    ///Init to create a WikiModel by title taken from the processed image
    public init(_ title: String) {
        baseUrl += title.replacingOccurrences(of: " ", with: "%20")
    }
    ///Get wiki content
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
                    if let name = subJson["extract"].string {
                        let text = (name).replacingOccurrences(of: "\n", with: "")
                        callback(text)
                    } else {
                        callback("No Description")
                    }
//                    let html = Data(subJson["extract"].string!.utf8)
//                    if let attributedString = try? NSAttributedString(data: html, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
//                        callback(attributedString.string.replacingOccurrences(of: "\n", with: ""))
//                    }
                    break
                }
            }
            catch {
                print(error)
            }
        }.resume()
    }
    
    ///Split paragraph by sentence
    /// - Parameter text: a paragraph to be splitted by sentence
    ///
    /// - Returns: an array of sentences
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
