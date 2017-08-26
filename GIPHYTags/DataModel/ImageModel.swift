//
//  ImageModel.swift
//  GIPHYTags
//
//  Created by David S Reich on 7/8/17.
//  Copyright © 2017 Stellar Software Pty Ltd. All rights reserved.
//

import Foundation

protocol ImageModelProtocol {
    func getImagePath() -> String
    func getTags() -> [String]
}

struct ImageModel {
    fileprivate var imagePath = ""
    fileprivate var tags = [String]()  //can't do Codable, because there is no simple mapping that will do String.components(separatedBy:)

    //parse the json
    init?(json: [String: Any]) {

        //use guard and return nil because we don't want to create this without an imagePath
        guard let media = json["media"] as? [String: Any],
            let imagePath = media["m"] as? String else { return nil }

        self.imagePath = imagePath

        if let tagString = json["tags"] as? String {
            tags = tagString.components(separatedBy: " ")
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
}

//Factory!
extension ImageModel {

    static func GetImages(from data: Data) -> [ImageModelProtocol] {
        var imageModels = [ImageModelProtocol]()

        var json = [String: Any]()

        if let json0 = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any] {
            json = json0
        } else {
            print("JSON conversion FAILED - trying data=>String=>data")
            if let jsonString = String(data: data, encoding: .utf8) {
                print(">>> \(jsonString)")
                if let jsonData = jsonString.data(using: .utf8) {
                    if let json0 = (try? JSONSerialization.jsonObject(with: jsonData)) as? [String: Any] {
                        json = json0
                        print(">>> JSON via String worked!")
                    }
                }
            }

            if json.count < 1 {
                print("Cannot convert data to JSON: \(data)")
                return imageModels
            }
        }

//        guard let json = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any] else {
//            print("Cannot convert data to JSON: \(data)")
//            return imageModels
//        }

        guard let allItems = json["items"] as? [[String: Any]] else {
            print("Cannot get \"items\" from json.")
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
