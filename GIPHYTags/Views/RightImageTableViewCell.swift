//
//  RightImageTableViewCell.swift
//  GIPHYTags
//
//  Created by David S Reich on 11/8/17.
//  Copyright © 2017 Stellar Software Pty Ltd. All rights reserved.
//

import UIKit

class RightImageTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewWithLoader: ImageViewWithAsynchLoader!
}

extension RightImageTableViewCell: ImageTableViewCellProtocol {
    func setupCell(imagePath: String, isGif: Bool) {
        imageViewWithLoader.loadCachedImageWithUrl(imageUrlString: imagePath, isGif: isGif)
    }
}
