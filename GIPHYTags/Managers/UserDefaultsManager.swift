//
//  UserDefaultsManager.swift
//  GIPHYTags
//
//  Created by David S Reich on 10/8/17.
//  Copyright © 2017 Stellar Software Pty Ltd. All rights reserved.
//

import Foundation

class UserDefaultsManager {

    static let APIURLKey = "apiurl"
    static let InitialTagsKey = "initialtags"
    static let MaxNumberOfImagesKey = "maxnumberofImages"
    static let MaxNumberOfLevelsKey = "maxnumberofLevels"

    static let defaultAPIURL = "http://api.flickr.com/services/feeds/photos_public.gne?&format=json&nojsoncallback=1&tags="
    static let defaultInitialTags = "weather"  //comma delimited list i.e. "tag1,tag2,tag3"
    static let defaultMaxNumberOfImages = 20
    static let defaultMaxNumberOfLevels = 10

    static let appDefaults = UserDefaults.standard

    //these could be get/set properties

    class func getAPIURL(defaults: UserDefaults = UserDefaultsManager.appDefaults) -> String {
        return defaults.string(forKey: APIURLKey) ?? defaultAPIURL
    }

    class func setAPIURL(apiUrl: String?, defaults: UserDefaults = UserDefaultsManager.appDefaults) {
        defaults.set(apiUrl, forKey: APIURLKey)
    }

    class func getInitialTags(defaults: UserDefaults = UserDefaultsManager.appDefaults) -> String {
        return defaults.string(forKey: InitialTagsKey) ?? defaultInitialTags
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

