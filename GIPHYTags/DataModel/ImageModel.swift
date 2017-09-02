//
//  ImageModel.swift
//  GIPHYTags
//
//  Created by David S Reich on 7/8/17.
//  Copyright © 2017 Stellar Software Pty Ltd. All rights reserved.
//

import UIKit

protocol ImageModelProtocol {
    func getImagePath() -> String
    func getTags() -> [String]
    func getIsGif() -> Bool
    func getImageSize() -> CGSize
    func getLargeImagePath() -> String
}

struct ImageModel {
    fileprivate var imagePath = ""
    fileprivate var largeImagePath = ""
    fileprivate var tags = [String]()  //can't do Codable, because there is no simple mapping that will do String.components(separatedBy:)
    fileprivate var isGif = true
    fileprivate var imageSize = CGSize()

    //parse the json
    init?(json: [String: Any]) {
        //use guard and return nil because we don't want to create this without an image
        guard let images = json["images"] as? [String: Any],
                let fixedWidth = images["fixed_width"] as? [String: Any],
                let imagePath = fixedWidth["url"] as? String else { return nil }

        self.imagePath = imagePath

        if let original = images["original"] as? [String: Any],
                let imagePath = original["url"] as? String {
            largeImagePath = imagePath
        }

        if let widthStr = fixedWidth["width"] as? String,
                let widthDouble = Double(widthStr) {
            imageSize.width = CGFloat(widthDouble)
        }

        if let heightStr = fixedWidth["height"] as? String,
            let heightDouble = Double(heightStr) {
            imageSize.height = CGFloat(heightDouble)
        }

        if let tagString = json["slug"] as? String {
            tags = tagString.components(separatedBy: "-")
            tags.removeLast()   //remove the id
        }
    }
}

extension ImageModel: ImageModelProtocol {

    func getImagePath() -> String {
        return imagePath
    }

    func getTags() -> [String] {
        return tags
    }

    func getIsGif() -> Bool {
        return isGif
    }

    func getImageSize() -> CGSize {
        return imageSize
    }

    func getLargeImagePath() -> String {
        return largeImagePath
    }
}

//Factory!
extension ImageModel {

    static func GetImages(from data: Data) -> [ImageModelProtocol] {
        var imageModels = [ImageModelProtocol]()

        guard let json = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any] else {
            print("Cannot convert data to JSON: \(data)")
            return imageModels
        }

        guard let allItems = json["data"] as? [[String: Any]] else {
            print("Cannot get \"data\" from json.")
            return imageModels
        }

        for fullItem in allItems {
            print("fullitem: \(fullItem)")
            if let imageModel = ImageModel(json: fullItem) {
                imageModels.append(imageModel)
            }

            if imageModels.count >= UserDefaultsManager.getMaxNumberOfImages() {
                break;
            }
        }

        return imageModels
    }
}
