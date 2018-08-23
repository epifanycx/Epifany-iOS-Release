//
//  MoodCell.swift
//  Epifany_Example
//
//  Created by Shawn Murphy on 1/15/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class MoodCell: UITableViewCell {
    let sadButton = UIButton()
    let indifferentButton = UIButton()
    let happyButton = UIButton()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.backgroundColor = UIColor.clear

        sadButton.setImage(UIImage(named: "icon_sad"), for: UIControlState())
        sadButton.alpha = 0.8
        sadButton.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(sadButton)

        indifferentButton.setImage(UIImage(named: "icon_neutral"), for: UIControlState())
        indifferentButton.alpha = 0.8
        indifferentButton.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(indifferentButton)

        happyButton.setImage(UIImage(named: "icon_happy"), for: UIControlState())
        happyButton.alpha = 0.8
        happyButton.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(happyButton)

        let views = [ "sadButton": sadButton, "indifferentButton": indifferentButton, "happyButton": happyButton ]  as [String: Any]

        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[sadButton(==indifferentButton)][indifferentButton(==happyButton)][happyButton(==sadButton)]-20-|", options: NSLayoutFormatOptions.alignAllCenterY, metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[sadButton(==68)]|", options: NSLayoutFormatOptions.alignAllLastBaseline, metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[indifferentButton(==68)]|", options: NSLayoutFormatOptions.alignAllLastBaseline, metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[happyButton(==68)]|", options: NSLayoutFormatOptions.alignAllLastBaseline, metrics: nil, views: views))
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    func pulseButton(_ button: UIButton) {
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.duration = 0.3
        pulseAnimation.fromValue = 1
        pulseAnimation.toValue = 0.75
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = 2
        button.layer.add(pulseAnimation, forKey: "scale")
    }
}
