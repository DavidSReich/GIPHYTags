//
//  ViewManager.swift
//  GIPHYTags
//
//  Created by David S Reich on 11/8/17.
//  Copyright © 2017 Stellar Software Pty Ltd. All rights reserved.
//

import UIKit

protocol ImageTableViewCellProtocol {
    func setupCell(imagePath: String, isGif: Bool)
}

class ViewManager: NSObject {

    fileprivate let leftImagesTableViewCellID = "LeftTableViewCell"
    fileprivate let rightImagesTableViewCellID = "RightTableViewCell"
    fileprivate var dataManagerDelegate: DataManagerProtocol

    init(dataManagerDelegate: DataManagerProtocol) {
        self.dataManagerDelegate = dataManagerDelegate
    }
}

extension ViewManager: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(dataManagerDelegate.imageCount(), UserDefaultsManager.getMaxNumberOfImages())
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = indexPath.row % 2 == 0 ? leftImagesTableViewCellID : rightImagesTableViewCellID
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if let imageModel = dataManagerDelegate.getImageModel(index: indexPath.row) {
            if let protocolCell = cell as? ImageTableViewCellProtocol {
                protocolCell.setupCell(imagePath: imageModel.getImagePath(), isGif: imageModel.getIsGif())
            }
        }

        cell?.backgroundColor = indexPath.row % 2 == 0 ? UIColor.groupTableViewBackground : UIColor.white
        return cell!
    }
}

extension ViewManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let imageModel = dataManagerDelegate.getImageModel(index: indexPath.row) {
            let imageSize = imageModel.getImageSize()
            let aspect = imageSize.height / imageSize.width
            return 150 * aspect
        }

        return 150
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

