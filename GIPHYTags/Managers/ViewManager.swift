//
//  ViewManager.swift
//  GIPHYTags
//
//  Created by David S Reich on 11/8/17.
//  Copyright © 2017 Stellar Software Pty Ltd. All rights reserved.
//

import UIKit

protocol ImageTableViewCellProtocol {
    func setupCell(imagePath: String, tableView: UITableView, isGif: Bool)
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
                protocolCell.setupCell(imagePath: imageModel.getImagePath(), tableView: tableView, isGif: imageModel.getIsGif())
            }
        }

        cell?.backgroundColor = indexPath.row % 2 == 0 ? UIColor.groupTableViewBackground : UIColor.white
        return cell!
    }
}

extension ViewManager: UITableViewDelegate {
    //These help automatic height calculation.
    //This could be done by setting the table view's properties instead.
    //But, we don't have (or want) access to the table view here,
    //and setting those properties in the MainVC sort of puts them where we don't want them.

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }


    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

