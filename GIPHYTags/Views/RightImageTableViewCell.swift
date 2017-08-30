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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension RightImageTableViewCell: ImageTableViewCellProtocol {
    func setupCell(imagePath: String, isGif: Bool) {
        imageViewWithLoader.loadCachedImageWithUrl(imageUrlString: imagePath, isGif: isGif)
    }
}
