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
//    private var gradientLayer = CAGradientLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
//        gradientLayer.frame = view.bounds
//        gradientLayer.colors = [UIColor.yellow, UIColor.cyan]
//        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
//        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
//        gradientLayer.locations = [ 0.0, 1.0]
//        view.layer.insertSublayer(gradientLayer, at: 0)

        imageViewWithLoader.loadCachedImageWithUrl(imageUrlString: imagePath, isGif: isGif)
    }
    
//maybe add an explicit UIView as the background to add a gradient to?

//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        gradientLayer.frame = view.bounds
//        gradientLayer.colors = [UIColor.yellow, UIColor.cyan]
//    }
}

extension ImageViewController: ImageTableViewCellProtocol {
    func setupCell(imagePath: String, isGif: Bool) {
        self.imagePath = imagePath
        self.isGif = isGif
    }
}
