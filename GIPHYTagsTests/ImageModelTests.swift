//
//  ImageModelTests.swift
//  GIPHYTagsTests
//
//  Created by David S Reich on 27/9/17.
//  Copyright © 2017 Stellar Software Pty Ltd. All rights reserved.
//

import XCTest

class ImageModelTests: BaseGIPHYTests {

    func testImageModelInit() {
        guard let imageJSON = getOneImageModelJSON() else {
            //this will have already failed before here.
            return
        }

        guard let imageModel = ImageModel(json: imageJSON) else {
            XCTFail("Cannot create ImageModel from: \(imageJSONString)")
            return
        }
        XCTAssertEqual(imagePath, imageModel.getImagePath())
        XCTAssertEqual(largeImagePath, imageModel.getLargeImagePath())

        let tagsStringSorted = tagsString.components(separatedBy: "-").sorted{$0 < $1}.joined(separator: "-")

        XCTAssertEqual(tagsStringSorted, imageModel.getTags().sorted{$0 < $1}.joined(separator: "-"))

        let (imageHeight, imageWidth) = (imageModel.getImageSize().height, imageModel.getImageSize().width)
        XCTAssertEqual(height, imageHeight)
        XCTAssertEqual(width, imageWidth)
    }

    func testGetImages() {
        guard let imagesJSONData = getFullQueryJSON() else {
            //this will have already failed before here.
            return
        }

        let imagemodels = ImageModel.GetImages(from: imagesJSONData)
        XCTAssertEqual(numberOfImagesInFullQuery, imagemodels.count)
    }
}
