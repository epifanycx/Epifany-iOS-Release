//
//  DateAnswerCell.swift
//  Epifany_Example
//
//  Created by Shawn Murphy on 1/15/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class DateAnswerCell: UITableViewCell {
    let textView = UITextView()
    let shapeLayer = CAShapeLayer()
    let datePickerView = UIDatePicker()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear

        shapeLayer.fillColor = nil
        shapeLayer.lineWidth = 1.0
        shapeLayer.strokeColor = UIColor.white.withAlphaComponent(0.3).cgColor
        self.layer.addSublayer(shapeLayer)

        textView.backgroundColor = UIColor.clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        datePickerView.datePickerMode = UIDatePickerMode.date
        textView.inputView = datePickerView
        textView.textAlignment = .center
        textView.isScrollEnabled = false
        self.contentView.addSubview(textView)

        let views = ["textView": textView]
        let constraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-100-[textView]-100-|", options: NSLayoutFormatOptions.alignAllLastBaseline, metrics: nil, views: views)
        NSLayoutConstraint.activate(constraint)
        NSLayoutConstraint.activate([NSLayoutConstraint(item: textView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0)])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let path = UIBezierPath(roundedRect: self.bounds.insetBy(dx: 95, dy: 0),
                                byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight],
                                cornerRadii: CGSize(width: 10.0, height: 10.0))
        shapeLayer.path = path.cgPath
    }
}
