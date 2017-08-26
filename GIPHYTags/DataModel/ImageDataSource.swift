//
//  ImageDataSource.swift
//  GIPHYTags
//
//  Created by David S Reich on 7/8/17.
//  Copyright © 2017 Stellar Software Pty Ltd. All rights reserved.
//

import Foundation

class ImageDataSource {
    private var images: [ImageModelProtocol]

    init(with images: [ImageModelProtocol]) {
        self.images = images
    }

    func clear() {
        images.removeAll()
    }

    func imageCount() -> Int {
        return images.count
    }

    func getImageModel(index: Int) -> ImageModelProtocol? {
        return index < imageCount() ? images[index] : nil
    }

    func getTagsArray() -> [String] {
        var tagsSet = Set<String>()

        for imageModel in images {
            tagsSet.formUnion(imageModel.getTags())
        }

        return [String](tagsSet).sorted{$0 < $1}
    }
}
