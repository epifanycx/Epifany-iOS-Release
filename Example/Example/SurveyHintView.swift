//
//  SurveyHintView.swift
//  Epifany_Example
//
//  Created by Shawn Murphy on 1/15/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class SurveyHintView: UIView {
    let label = UILabel()
    let textField = UITextView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = UIColor.white

        let labelBackgroundView = UIView()
        labelBackgroundView.backgroundColor = UIColor.red
        self.addSubview(labelBackgroundView)

        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        labelBackgroundView.addSubview(label)

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont()
        textField.textColor = UIColor.white
        textField.textAlignment = NSTextAlignment.left
        self.addSubview(textField)

        let views = [ "labelBackgroundView": labelBackgroundView, "label": label, "textField": textField ] as [String: Any]

        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[labelBackgroundView][textField]|", options: NSLayoutFormatOptions.alignAllLastBaseline, metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[label]-5-|", options: NSLayoutFormatOptions.alignAllLastBaseline, metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[textField]-5-|", options: NSLayoutFormatOptions.alignAllLastBaseline, metrics: nil, views: views))

        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[label]-5-|", options: NSLayoutFormatOptions.alignAllLastBaseline, metrics: nil, views: views))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

}
