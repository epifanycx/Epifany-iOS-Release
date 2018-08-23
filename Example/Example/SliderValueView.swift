//
//  SliderValueView.swift
//  Epifany_Example
//
//  Created by Shawn Murphy on 1/15/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class SliderValueView: UIView {
    let valueBackgroundView = UIImageView()
    let valueLabel: UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        valueBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        valueBackgroundView.backgroundColor = UIColor.clear
        valueBackgroundView.image = UIImage(named: "slider_value_background")?.resizableImage(withCapInsets: UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0))
        self.addSubview(valueBackgroundView)

        let valueChevronView = UIImageView(image: UIImage(named: "slider_value_chevron"))
        valueChevronView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(valueChevronView)

        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.textAlignment = .center
        valueLabel.textColor = UIColor.primaryColor()
        valueBackgroundView.addSubview(valueLabel)

        let views = ["valueBackgroundView": valueBackgroundView, "valueChevronView": valueChevronView, "valueLabel": valueLabel ] as [String: Any]

        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[valueBackgroundView(==50)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[valueBackgroundView(==50)][valueChevronView(==7)]|", options: .alignAllCenterX, metrics: nil, views: views))

        valueBackgroundView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-2-[valueLabel]-2-|", options: .alignAllCenterY, metrics: nil, views: views))
        valueBackgroundView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-2-[valueLabel]-2-|", options: .alignAllCenterY, metrics: nil, views: views))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override var intrinsicContentSize: CGSize {
        get {
            return CGSize(width: 50.0, height: 57.0)
        }
    }
}

