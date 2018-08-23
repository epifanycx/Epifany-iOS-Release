//
//  AnswerCell.swift
//  Epifany_Example
//
//  Created by Shawn Murphy on 1/15/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

enum AnswerCellPosition {
    case top
    case middle
    case bottom
    case single
}

class AnswerCell: UITableViewCell {
    let selectedView = UIImageView()
    let answerLabel = UILabel()
    let shapeLayer = CAShapeLayer()
    var position: AnswerCellPosition = .top

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.selectionStyle = UITableViewCellSelectionStyle.none
        self.backgroundColor = UIColor.clear

        shapeLayer.fillColor = nil
        shapeLayer.lineWidth = 1.0
        shapeLayer.strokeColor = UIColor.white.withAlphaComponent(0.3).cgColor
        self.layer.addSublayer(shapeLayer)

        self.bringSubview(toFront: self.contentView)

        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.textColor = UIColor.white
        answerLabel.numberOfLines = 0
        self.contentView.addSubview(answerLabel)

        selectedView.translatesAutoresizingMaskIntoConstraints = false
        selectedView.image = UIImage(named: "multipleChoice_selector_normal")
        self.contentView.addSubview(selectedView)

        let views: [String: UIView] = [ "answerLabel": answerLabel, "selectedView": selectedView ]

        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[answerLabel]-8-|", options: NSLayoutFormatOptions.alignAllLastBaseline, metrics: nil, views: views))
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[selectedView(==24)]-16-[answerLabel]-30-|", options: NSLayoutFormatOptions.alignAllCenterY, metrics: nil, views: views))
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            self.shapeLayer.fillColor = UIColor.white.withAlphaComponent(0.3).cgColor
            selectedView.image = UIImage(named: "multipleChoice_selector_active")
        } else {
            self.shapeLayer.fillColor = UIColor.clear.cgColor
            selectedView.image = UIImage(named: "multipleChoice_selector_normal")
        }
    }

    static func heightWithAnswer(_ answer: NSString) -> CGFloat {
        let availableWidth = UIScreen.main.bounds.size.width - (32 + 24 + 30 + 50)

        let height: CGFloat = 45.0
        let rect = answer.boundingRect(with: CGSize(width: availableWidth, height: CGFloat(Float.greatestFiniteMagnitude)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [ .font: UILabel().font ], context: nil)

        let actualHeight = rect.size.height + 16.0
        if actualHeight > height {
            return ceil(actualHeight)
        } else {
            return height
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        var positions: UIRectCorner = UIRectCorner()

        switch position {
        case .top:
            positions = [.topLeft, .topRight]
            break
        case .bottom:
            positions = [.bottomLeft, .bottomRight]
            break
        case .middle:
            positions = []
            break
        default: ()
        }

        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: positions,
                                cornerRadii: CGSize(width: 10.0, height: 10.0))
        shapeLayer.path = path.cgPath

    }

    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            frame.origin.x += 25
            frame.size.width -= 50
            super.frame = frame
        }
    }

}
