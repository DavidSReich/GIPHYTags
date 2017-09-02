//
//  DataManager.swift
//  GIPHYTags
//
//  Created by David S Reich on 10/8/17.
//  Copyright © 2017 Stellar Software Pty Ltd. All rights reserved.
//

import Foundation

protocol DataManagerProtocol {
    func imageCount() -> Int
    func getImageModel(index: Int) -> ImageModelProtocol?
    func getTagsArray() -> [String]
}

class DataManager {

    fileprivate var imageDataSource = ImageDataSource(with: [])

    func populateDataSource(tagsString: String, completion: @escaping () -> ()) {

        let result = JSONNetworkService.getJSON(tagsString: tagsString) { data, error in
            guard error == nil else {
                print("\(error!)")
                return
            }
            guard let data = data else {
                print("No data!")
                return
            }

            let imagemodels = ImageModel.GetImages(from: data)
            //print("imagemodels: \(imagemodels)")
            print("imagemodels.count: \(imagemodels.count)")

            self.imageDataSource = ImageDataSource(with: imagemodels)
            completion()
        }

        if !result {
            print("Couldn't fetch JSON")
        }
    }

    func clearDataSource() {
        imageDataSource.clear()
    }
}

//this mainly just hides the imageDataSource
extension DataManager: DataManagerProtocol {
    func imageCount() -> Int {
        return imageDataSource.imageCount()
    }

    func getImageModel(index: Int) -> ImageModelProtocol? {
        return imageDataSource.getImageModel(index: index)
    }

    func getTagsArray() -> [String] {
        return imageDataSource.getTagsArray()
    }
}

