//
//  OpenCell.swift
//  Epifany_Example
//
//  Created by Shawn Murphy on 1/15/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class OpenCell: UITableViewCell {
    let textView = UITextView()
    let shapeLayer = CAShapeLayer()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.backgroundColor = UIColor.clear

        shapeLayer.fillColor = nil
        shapeLayer.lineWidth = 1.0
        shapeLayer.strokeColor = UIColor.white.withAlphaComponent(0.3).cgColor
        self.layer.addSublayer(shapeLayer)

        textView.backgroundColor = UIColor.clear
        textView.translatesAutoresizingMaskIntoConstraints = false
//        textView.font = UIFont(.stzBodyThree())
//        textView.textColor = UIColor.white

        textView.inputAccessoryView = SurveyHintView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: 50.0))
        self.contentView.addSubview(textView)
        let views = [ "textView": textView ]

        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[textView]|", options: NSLayoutFormatOptions.alignAllLastBaseline, metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[textView]-30-|", options: NSLayoutFormatOptions.alignAllLastBaseline, metrics: nil, views: views))
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let path = UIBezierPath(roundedRect: self.bounds.insetBy(dx: 25, dy: 0),
                                byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight],
                                cornerRadii: CGSize(width: 10.0, height: 10.0))
        shapeLayer.path = path.cgPath
    }

}

