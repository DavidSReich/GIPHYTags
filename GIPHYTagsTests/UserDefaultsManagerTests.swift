//
//  UserDefaultsManagerTests.swift
//  GIPHYTagsTests
//
//  Created by David S Reich on 27/9/17.
//  Copyright © 2017 Stellar Software Pty Ltd. All rights reserved.
//

import XCTest
@testable import GIPHYTags

class UserDefaultsManagerTests: XCTestCase {

    func testInitialTags() {
        let testTags = "weather,storm"
        let testDefaults = UserDefaults()

        UserDefaultsManager.setInitialTags(initialTags: testTags, defaults: testDefaults)
        let tags = UserDefaultsManager.getInitialTags(defaults: testDefaults)

        XCTAssertEqual(testTags, tags)
    }

    func testMaxNumberOfImages() {
        let testNumber = 24
        let testDefaults = UserDefaults()

        UserDefaultsManager.setMaxNumberOfImages(maxNumber: testNumber, defaults: testDefaults)
        let numberOfImages = UserDefaultsManager.getMaxNumberOfImages(defaults: testDefaults)

        XCTAssertEqual(testNumber, numberOfImages)
    }

    func testMaxNumberOfLevels() {
        let testNumber = 9
        let testDefaults = UserDefaults()

        UserDefaultsManager.setMaxNumberOfLevels(maxNumber: testNumber, defaults: testDefaults)
        let numberOfLevels = UserDefaultsManager.getMaxNumberOfLevels(defaults: testDefaults)

        XCTAssertEqual(testNumber, numberOfLevels)
    }
}

