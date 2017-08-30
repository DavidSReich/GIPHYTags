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

    func loadCachedImageWithUrl(imageUrlString: String, imageViewHeightConstraint: NSLayoutConstraint, tableView: UITableView, isGif: Bool) {
        self.image = nil

        //if we already are downloading a file stop it - we won't need that one.
        if downloadTask != nil {
            downloadTask?.cancel()
        }

        //let's cache images - helpful if network is slow or we are actually viewing a lot more works
        if let cachedImage = ImageViewWithAsynchLoader.imageCache.object(forKey: imageUrlString as NSString) {
            self.setImage(image: cachedImage, imageViewHeightConstraint: imageViewHeightConstraint, tableView: tableView)
//            self.image = cachedImage
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
                    self.setImage(image: image, imageViewHeightConstraint: imageViewHeightConstraint, tableView: tableView)
//                    self.image = image
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
                    self.setImage(image: image, imageViewHeightConstraint: imageViewHeightConstraint, tableView: tableView)
//                    self.image = image
//                    let aspect = image.size.height / image.size.width
//                    imageViewHeightConstraint.constant = aspect * self.bounds.width
//                    self.superview?.needsUpdateConstraints()
//                    self.superview?.updateConstraints()
                })
            }

            guard let task = downloadTask else {
                return
            }

            task.resume()
        }
    }

    private func setImage(image: UIImage, imageViewHeightConstraint: NSLayoutConstraint, tableView: UITableView) {
        self.image = image
        let aspect = image.size.height / image.size.width
        tableView.beginUpdates()
        imageViewHeightConstraint.constant = aspect * self.bounds.width
        self.superview?.needsUpdateConstraints()
        self.superview?.updateConstraints()
        tableView.needsUpdateConstraints()
        tableView.updateConstraints()
//        tableView.setNeedsLayout()
//        tableView.layoutIfNeeded()
//        tableView.layoutSubviews()
        tableView.reloadRows(at: tableView.indexPathsForVisibleRows!, with: .none)
        tableView.endUpdates()
    }
}
