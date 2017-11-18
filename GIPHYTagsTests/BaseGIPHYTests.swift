//
//  BaseGIPHYTests.swift
//  GIPHYTagsTests
//
//  Created by David S Reich on 27/9/17.
//  Copyright © 2017 Stellar Software Pty Ltd. All rights reserved.
//

import XCTest
@testable import GIPHYTags

//only general code goes here ... nothing here knows about any GIPHYTags app code

class BaseGIPHYTests: XCTestCase {
    
    let imagePath = "https://media2.giphy.com/media/FiGiRei2ICzzG/200w.gif"
    let largeImagePath = "https://media2.giphy.com/media/FiGiRei2ICzzG/giphy.gif"
    let tagsString = "funny-cat"
    var tagsString2 = ""
    let width = CGFloat(200)
    let height = CGFloat(70)

    var imageJSONString = ""

    let imageJSONString1 = "{\"slug\": \"funny-cat-mlvseq9yvZhba\",\"images\": {\"fixed_width\": {\"url\": \"https://media2.giphy.com/media/mlvseq9yvZhba/200w.gif\",\"width\": \"200\",\"height\": \"200\"},\"original\": {\"url\": \"https://media2.giphy.com/media/mlvseq9yvZhba/giphy.gif\",\"width\": \"200\",\"height\": \"200\"}}}"
    var imageJSONString2 = ""
    let imageJSONString3 = "{\"slug\": \"funny-cat-6bAZXey5wNzBC\",\"images\": {\"fixed_width\": {\"url\": \"https://media2.giphy.com/media/6bAZXey5wNzBC/200w.gif\",\"width\": \"200\",\"height\": \"140\"},\"original\": {\"url\": \"https://media2.giphy.com/media/6bAZXey5wNzBC/giphy.gif\",\"width\": \"339\",\"height\": \"237\"}}}"
    var fullQueryJSONString = ""
    var numberOfImagesInFullQuery = 0

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        tagsString2 = tagsString + "-FiGiRei2ICzzG"
        imageJSONString = "{\"slug\": \"\(tagsString2)\",\"images\": {\"fixed_width\": {\"url\": \"\(imagePath)\",\"width\": \"\(width)\",\"height\": \"\(height)\"},\"original\": {\"url\": \"\(largeImagePath)\",\"width\": \"500\",\"height\": \"176\"}}}"
        imageJSONString2 = imageJSONString
        fullQueryJSONString = "{\"data\": [" + imageJSONString1 + "," + imageJSONString2 + "," + imageJSONString3 + "]}"
        numberOfImagesInFullQuery = 3
    }

    func getOneImageModelJSON() -> [String: Any]? {
        return setupJSON(from: imageJSONString)
    }

    func getFullQueryJSON() -> Data? {
        return setupJSONData(from: fullQueryJSONString)
    }

    func setupJSONData(from jsonString: String) -> Data? {
        guard let imageJSONData = jsonString.data(using: .utf8) else {
            XCTFail("Couldn't convert \"\(jsonString)\" into Data.")
            return nil
        }
        return imageJSONData
    }

    func setupJSON(from jsonString: String) -> [String: Any]? {
        guard let imageJSONData = setupJSONData(from: jsonString) else {
            return nil
        }

        guard let json = (try? JSONSerialization.jsonObject(with: imageJSONData)) as? [String: Any] else {
            XCTFail("Cannot convert data to JSON: \(imageJSONData)")
            return nil
        }

        return json
    }
}
