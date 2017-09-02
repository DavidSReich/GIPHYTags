//
//  ImageViewController.swift
//  GIPHYTags
//
//  Created by David S Reich on 1/9/17.
//  Copyright © 2017 Stellar Software Pty Ltd. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var imageViewWithLoader: ImageViewWithAsynchLoader!

    private var imagePath = ""
    private var isGif = true

    override func viewDidLoad() {
        super.viewDidLoad()

        imageViewWithLoader.loadCachedImageWithUrl(imageUrlString: imagePath, isGif: isGif)
    }
}

extension ImageViewController: ImageTableViewCellProtocol {
    func setupCell(imagePath: String, isGif: Bool) {
        self.imagePath = imagePath
        self.isGif = isGif
    }
}
