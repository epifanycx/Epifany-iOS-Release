//
//  SliderCell.swift
//  Epifany_Example
//
//  Created by Shawn Murphy on 1/15/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class SliderCell: UITableViewCell {
    let sliderView: Slider = Slider()
    let valueView = SliderValueView()
    let leftLabel = UILabel()
    let rightLabel = UILabel()

    var valueConstraint: NSLayoutConstraint?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.backgroundColor = UIColor.clear

        valueView.translatesAutoresizingMaskIntoConstraints = false
        valueView.isHidden = true
        self.contentView.addSubview(valueView)

        let sliderBackgroundView = UIImageView(image: UIImage(named: "firstSlider_background")?.resizableImage(withCapInsets: UIEdgeInsetsMake(23.0, 21.0, 23.0, 21.0)))
        sliderBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        sliderBackgroundView.isUserInteractionEnabled = true
        self.contentView.addSubview(sliderBackgroundView)

        sliderView.translatesAutoresizingMaskIntoConstraints = false
        sliderView.tintColor = UIColor.white
        sliderView.setMinimumTrackImage(UIImage(named: "firstSlider_activeIndicator_lightBlue")?.resizableImage(withCapInsets: UIEdgeInsetsMake(16.0, 16.0, 16.0, 16.0)), for: .normal)
        sliderView.setMaximumTrackImage(getImageWithColor(color: UIColor.clear, size: CGSize(width: 1.0, height: 32.0)), for: .normal)
        sliderView.addTarget(self, action: #selector(sliderDidChange), for: .valueChanged)
        sliderBackgroundView.addSubview(sliderView)

        sliderView.setThumbImage(getImageWithColor(color: UIColor.clear, size: CGSize(width: 1.0, height: 1.0)), for: .normal)

        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        leftLabel.textAlignment = .right
        leftLabel.textColor = .white
        self.contentView.addSubview(leftLabel)

        rightLabel.translatesAutoresizingMaskIntoConstraints = false
        rightLabel.textAlignment = .left
        rightLabel.textColor = .white
        self.contentView.addSubview(rightLabel)

        let views = [ "sliderView": sliderView, "rightLabel": rightLabel, "leftLabel": leftLabel, "valueView": valueView, "sliderBackgroundView": sliderBackgroundView ] as [String: Any]

        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[valueView]-5-[sliderBackgroundView][leftLabel]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        sliderBackgroundView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[sliderView]-8-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        sliderBackgroundView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-1-[sliderView]-3-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))

        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[sliderBackgroundView(==40)]-5-[rightLabel]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[sliderBackgroundView(==40)]-5-[leftLabel]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[sliderBackgroundView]-30-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[leftLabel]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[rightLabel]-30-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))


        self.valueConstraint = NSLayoutConstraint(item: valueView, attribute: .centerX, relatedBy: .equal, toItem: sliderBackgroundView, attribute: .left, multiplier: 1.0, constant: 0.0)
        self.contentView.addConstraint(self.valueConstraint!)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func sliderDidChange() {
        let roundedValue = self.sliderView.value.rounded(.toNearestOrAwayFromZero)
        self.sliderView.setValue(roundedValue, animated: true)

        let rect = self.sliderView.thumbRect(forBounds: self.sliderView.bounds, trackRect: self.sliderView.trackRect(forBounds: self.sliderView.bounds), value: self.sliderView.value)
        self.valueConstraint?.constant = rect.midX + 3
    }

    func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    class func height() -> CGFloat {
        return 137.0
    }

}

