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

    //https://api.giphy.com/v1/gifs/search?api_key=39e2cefae3444ec79e277251af1f0848&q=funny+cat
	//"https://api.giphy.com/v1/gifs/search?api_key=39e2cefae3444ec79e277251af1f0848&limit=25&offset=0&rating=G&lang=en&q=cows"
    static let GIPHYApiKey = "39e2cefae3444ec79e277251af1f0848"
    static let giphyAPIURL = "https://api.giphy.com/v1/gifs/search?api_key=" + GIPHYApiKey + "&q="

    static let defaultInitialTags = "weather"  //plus delimited list i.e. "tag1+tag2+tag3", or comma delimited, etc.
    static let defaultMaxNumberOfImages = 25
    static let defaultMaxNumberOfLevels = 10

    static let appDefaults = UserDefaults.standard

    class var tagsSeparator: String {
        get {
            return "+"
        }
    }

    //these could be get/set properties

    class func getAPIURL(defaults: UserDefaults = UserDefaultsManager.appDefaults) -> String {
        return giphyAPIURL
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

    class func synchronizeUserDefaults() {
        appDefaults.synchronize()
    }
}

