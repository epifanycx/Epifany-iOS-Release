//
//  GradientView.swift
//  Epifany_Example
//
//  Created by Shawn Murphy on 5/11/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class GradientView: UIView {

    var topColor = UIColor()
    var bottomColor = UIColor()
    var gradientLayer = CAGradientLayer()

    init() {
        super.init(frame: .zero)

        topColor = UIColor.primaryColor()
        bottomColor = UIColor.gradientBottom()

        let gradientLayer = CAGradientLayer()
        gradientLayer.locations = [(0.0), (1.0)]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: 300, height: 300)
        layer.insertSublayer(gradientLayer, at: 0)
        self.gradientLayer = gradientLayer

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.colors = [(topColor.cgColor as? Any), (bottomColor.cgColor as? Any)]
        gradientLayer.frame = bounds
    }
}
