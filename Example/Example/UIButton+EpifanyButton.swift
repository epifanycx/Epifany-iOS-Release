//
//  UIButton+EpifanyButton.swift
//  Epifany_Example
//
//  Created by Shawn Murphy on 7/18/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation


extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControlState) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        self.setBackgroundImage(colorImage, for: forState)
    }

    class func baseButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.titleLabel?.textColor = .primaryColor()
        button.setBackgroundColor(color: .white, forState: .normal)
        button.setBackgroundColor(color: UIColor.white.withAlphaComponent(0.80), forState: .highlighted)
        button.layer.cornerRadius = 4.0
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.clipsToBounds = true
        button.setTitleColor(UIColor.primaryColor(), for: .normal)
        button.contentEdgeInsets = UIEdgeInsetsMake(11.0, 24.0, 11.0, 24.0)
        button.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 250), for: .horizontal)
        button.translatesAutoresizingMaskIntoConstraints = true
        return button
    }
}


