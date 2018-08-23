//
//  QuestionHeaderView.swift
//  Epifany_Example
//
//  Created by Shawn Murphy on 1/15/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class QuestionHeaderView: UIView {
    let textLabel: UILabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)

        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        textLabel.numberOfLines = 0
        textLabel.textColor = UIColor.white
        textLabel.lineBreakMode = .byWordWrapping
        textLabel.textAlignment = NSTextAlignment.center
        self.addSubview(textLabel)

        let views = [ "textLabel": textLabel ]

        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-24-[textLabel]-24-|", options: NSLayoutFormatOptions.alignAllLastBaseline, metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[textLabel]-30-|", options: NSLayoutFormatOptions.alignAllLastBaseline, metrics: nil, views: views))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    static func heightForText(_ text: NSString) -> CGFloat {
        let availableWidth = UIScreen.main.bounds.size.width - 40

        let height: CGFloat = 48.0
        let rect = text.boundingRect(with: CGSize(width: availableWidth, height: CGFloat(FLT_MAX)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: nil, context: nil)

        let actualHeight = rect.size.height + 100.0
        if actualHeight > height {
            return ceil(actualHeight)
        } else {
            return height
        }
    }

}

