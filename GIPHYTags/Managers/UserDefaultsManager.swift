//
//  UserDefaultsManager.swift
//  GIPHYTags
//
//  Created by David S Reich on 10/8/17.
//  Copyright © 2017 Stellar Software Pty Ltd. All rights reserved.
//

import Foundation

//UserDefaults plus ...

class UserDefaultsManager {

    static let InitialTagsKey = "initialtags"
    static let MaxNumberOfImagesKey = "maxnumberofImages"
    static let MaxNumberOfLevelsKey = "maxnumberofLevels"
    static let GIPHYApiKeyKey = "GIPHYApiKey"

    static let giphyAPIURLFront = "https://api.giphy.com/v1/gifs/search?api_key="
    static let giphyAPIURLMiddle = "&limit="
    static let giphyAPIURLBack = "&q="

    static let defaultInitialTags = "weather"  //plus delimited list i.e. "tag1+tag2+tag3"
    static let defaultMaxNumberOfImages = 25
    static let defaultMaxNumberOfLevels = 10

    static let appDefaults = UserDefaults.standard

    //remove this ... set to "" for publication
    static let defaultGIPHYApiKey = "39e2cefae3444ec79e277251af1f0848"

    class var GIPHYApiKey: String {
        get {
            return appDefaults.string(forKey: GIPHYApiKeyKey) ?? ""
        }
        set(newApiKey) {
            appDefaults.set(newApiKey, forKey: GIPHYApiKeyKey)
        }
    }

    class var tagsSeparator: String {
        get {
            return "+"
        }
    }

    class var APIURL: String {
        get {
            return giphyAPIURLFront + GIPHYApiKey + giphyAPIURLMiddle + "\(UserDefaultsManager.getMaxNumberOfImages)" + giphyAPIURLBack
        }
    }

    class func getInitialTags(defaults: UserDefaults = UserDefaultsManager.appDefaults) -> String {
        guard let tags = defaults.string(forKey: InitialTagsKey) else {
            return defaultInitialTags
        }
        return tags.isEmpty ? defaultInitialTags : tags
    }

    class func setInitialTags(initialTags: String?, defaults: UserDefaults = UserDefaultsManager.appDefaults) {
        defaults.set(initialTags, forKey: InitialTagsKey)
    }

    class func getMaxNumberOfImages(defaults: UserDefaults = UserDefaultsManager.appDefaults) -> Int {
        let number = defaults.integer(forKey: MaxNumberOfImagesKey)
        return number <= 0 ? defaultMaxNumberOfImages : number
    }

    class func setMaxNumberOfImages(maxNumber: Int, defaults: UserDefaults = UserDefaultsManager.appDefaults) {
        defaults.set(maxNumber, forKey: MaxNumberOfImagesKey)
    }

    class func getMaxNumberOfLevels(defaults: UserDefaults = UserDefaultsManager.appDefaults) -> Int {
        let number = defaults.integer(forKey: MaxNumberOfLevelsKey)
        return number <= 0 ? defaultMaxNumberOfLevels : number
    }

    class func setMaxNumberOfLevels(maxNumber: Int, defaults: UserDefaults = UserDefaultsManager.appDefaults) {
        defaults.set(maxNumber, forKey: MaxNumberOfLevelsKey)
    }

    //this method is not used currently, although it could become necessary in a more complex application.
    class func synchronizeUserDefaults() {
        appDefaults.synchronize()
    }
}

