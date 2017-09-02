//
//  GradientView.swift
//  GIPHYTags
//
//  Created by David S Reich on 1/9/17.
//  Copyright © 2017 Stellar Software Pty Ltd. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {

    @IBInspectable var firstColor: UIColor = UIColor.white {
        didSet {
            updateColors()
        }
    }

    @IBInspectable var lastColor: UIColor = UIColor.black {
        didSet {
            updateColors()
        }
    }

    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [self.firstColor.cgColor, self.lastColor.cgColor]
        return gradientLayer
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.insertSublayer(gradientLayer, at: 0)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.insertSublayer(gradientLayer, at: 0)
    }

    override func layoutSubviews() {
        gradientLayer.frame = bounds
    }

    private func updateColors() {
        gradientLayer.colors = [firstColor.cgColor, lastColor.cgColor]
        setNeedsLayout()
    }
}
