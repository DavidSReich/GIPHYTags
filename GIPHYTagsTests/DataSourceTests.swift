//
//  DataSourceTests.swift
//  GIPHYTagsTests
//
//  Created by David S Reich on 27/9/17.
//  Copyright © 2017 Stellar Software Pty Ltd. All rights reserved.
//

import XCTest

class DataSourceTests: BaseGIPHYTests {

    func getDataSource() -> ImageDataSource? {
        guard let imagesJSONData = getFullQueryJSON() else {
            //this will have already failed before here.
            return nil
        }

        let imagemodels = ImageModel.GetImages(from: imagesJSONData)
        XCTAssertEqual(numberOfImagesInFullQuery, imagemodels.count)

        let datasource = ImageDataSource(with: imagemodels)
        XCTAssertEqual(numberOfImagesInFullQuery, datasource.imageCount())
        return datasource
    }

    func testDataSource() {
        guard let datasource = getDataSource() else {
            //this will have already failed before here.
            return
        }

        XCTAssertEqual(numberOfImagesInFullQuery, datasource.imageCount())

        let tagsStringSorted = tagsString.components(separatedBy: "-").sorted{$0 < $1}.joined(separator: "-")

        XCTAssertEqual(tagsStringSorted, datasource.getTagsArray().joined(separator: "-"))

        guard let imageModel = datasource.getImageModel(index: 1) else {
            XCTFail("Couldn't find the second imageModel.")
            return
        }

        XCTAssertEqual(imagePath, imageModel.getImagePath())
        XCTAssertEqual(largeImagePath, imageModel.getLargeImagePath())
        XCTAssertEqual(tagsString, imageModel.getTags().joined(separator: "-"))
        let (imageHeight, imageWidth) = (imageModel.getImageSize().height, imageModel.getImageSize().width)
        XCTAssertEqual(height, imageHeight)
        XCTAssertEqual(width, imageWidth)
    }

}
