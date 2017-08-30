//
//  ImageViewWithAsynchLoader.swift
//  GIPHYTags
//
//  Created by David S Reich on 10/8/17.
//  Copyright © 2017 Stellar Software Pty Ltd. All rights reserved.
//

import UIKit
import SwiftGifOrigin

//this isn't a UIImageView extension, because we want a class imageCache
class ImageViewWithAsynchLoader: UIImageView {
    static let imageCache = NSCache<NSString, UIImage>()

    private var downloadTask: URLSessionDataTask?

    func loadCachedImageWithUrl(imageUrlString: String, isGif: Bool) {
        self.image = nil

        //if we already are downloading a file stop it - we won't need that one.
        if downloadTask != nil {
            downloadTask?.cancel()
        }

        //let's cache images - helpful if network is slow or we are actually viewing a lot more works
        if let cachedImage = ImageViewWithAsynchLoader.imageCache.object(forKey: imageUrlString as NSString) {
            self.image = cachedImage
            return
        }

        if isGif {
            //SwiftGif cannot use Data from URLSession.urlSessionDataTask
            DispatchQueue.global().async {
                guard let image = UIImage.gif(url: imageUrlString) else {
                    print("Can't load gif image!")
                    return
                }
                DispatchQueue.main.async {
                    ImageViewWithAsynchLoader.imageCache.setObject(image, forKey: imageUrlString as NSString)
                    self.image = image
                }
            }
        } else {
            downloadTask = URLSession.urlSessionDataTask(urlString: imageUrlString) { data, error in
                guard error == nil else {
                    print("\(error!)")
                    return
                }
                guard let data = data else {
                    print("No data!")
                    return
                }

                guard let image = UIImage(data: data) else {
                    print("Can't convert data into image!")
                    return
                }

                DispatchQueue.main.async(execute: { () -> Void in
                    ImageViewWithAsynchLoader.imageCache.setObject(image, forKey: imageUrlString as NSString)
                    self.image = image
                })
            }

            guard let task = downloadTask else {
                return
            }

            task.resume()
        }
    }
}
