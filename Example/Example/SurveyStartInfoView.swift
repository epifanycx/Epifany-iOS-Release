//
//  SurveyStartInfoView.swift
//  Epifany_Example
//
//  Created by Shawn Murphy on 1/15/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class SurveyStartInfoView: UIView {
    let titleLabel: UILabel = UILabel()
    let descriptionLabel: UILabel = UILabel()
    let iconBackgroundImageView = UIImageView()
    let iconImageView: UIImageView = UIImageView()
    let dividerView: UIView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)


        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(descriptionLabel)

        iconBackgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(iconBackgroundImageView)

        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconBackgroundImageView.addSubview(iconImageView)

        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = UIColor.white
        self.addSubview(dividerView)

        let views = ["titleLabel": titleLabel, "descriptionLabel": descriptionLabel, "iconImageView": iconImageView, "dividerView": dividerView, "iconBackgroundImageView": iconBackgroundImageView]

        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[iconBackgroundImageView(==29)]-14-[titleLabel]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[iconBackgroundImageView(==29)]-14-[descriptionLabel]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))

        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[titleLabel][descriptionLabel]-20-[dividerView(==1)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))

        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[iconBackgroundImageView(==29)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.addConstraint(NSLayoutConstraint(item: iconImageView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0.0))

        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[dividerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))

        iconBackgroundImageView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-1-[iconImageView]-1-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        iconBackgroundImageView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-1-[iconImageView]-1-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

