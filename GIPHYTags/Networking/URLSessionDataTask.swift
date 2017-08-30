//
//  URLSessionDataTask.swift
//  GIPHYTags
//
//  Created by David S Reich on 7/8/17.
//  Copyright © 2017 Stellar Software Pty Ltd. All rights reserved.
//

import Foundation

//this doesn't really extend URLSession -
// it's just a global helper function -
// should be in its own class
extension URLSession {
    class func urlSessionDataTask(urlString: String, completion: @escaping (Data?, Error?) -> ()) -> URLSessionDataTask? {

//        let urlString = "https://api.giphy.com/v1/gifs/search?api_key=3939e2cefae3444ec79e277251af1f0848&q=weather"
//        let urlString = "http://api.giphy.com/v1/gifs/search?q=weather&api_key=3939e2cefae3444ec79e277251af1f0848"
        // cows good:
//        let urlString = "https://api.giphy.com/v1/gifs/search?api_key=39e2cefae3444ec79e277251af1f0848&limit=25&offset=0&rating=G&lang=en&q=cows"
        guard let url = URL(string: urlString) else {
            print("Cannot make URL from: \(urlString)")
            return nil
        }

        //urlString  "https://api.giphy.com/v1/gifs/search?api_key=3939e2cefae3444ec79e277251af1f0848&q=weather"    

        print("URL: \(url)")
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print("DataTask error: \(error!)")
                return
            }

            guard let response = response else {
                print("No response.")
                return
            }

            guard let urlResponse = response as? HTTPURLResponse else {
                print("Response not URLResponse: \(response).")
                return
            }

            guard urlResponse.statusCode == 200 else {
                print("Bad response statusCode = \(urlResponse.statusCode)")
                return
            }

            guard let data = data else {
                print("No data.")
//                completion(nil, Error())
                return
            }

            DispatchQueue.main.async {
                completion(data, nil)
            }
        }

        return dataTask
    }
}
