//
//  JSONNetworkService.swift
//  GIPHYTags
//
//  Created by David S Reich on 7/8/17.
//  Copyright © 2017 Stellar Software Pty Ltd. All rights reserved.
//

import Foundation

class JSONNetworkService {

    class func getJSON(tagsString: String, completion: @escaping (Data?, Error?) -> ()) -> Bool {
        guard let tagsString = tagsString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return false }

        let urlString = UserDefaultsManager.getAPIURL() + tagsString

        guard let dataTask = URLSession.urlSessionDataTask(urlString: urlString, completion: completion) else {
            return false
        }

        dataTask.resume()

        return true
    }

}
