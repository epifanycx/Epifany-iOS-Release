//
//  Slider.swift
//  Epifany_Example
//
//  Created by Shawn Murphy on 8/6/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

class Slider: UISlider {
    let numberView = UIView()
    var displayValues: [String]? {
        didSet {
            var previousLabel: UILabel?
            for string in self.displayValues! {
                let label = UILabel()
                label.translatesAutoresizingMaskIntoConstraints = false
                label.text = string
                label.textAlignment = .center
                label.textColor = UIColor.primaryColor()

                numberView.addSubview(label)

                if let oldLabel = previousLabel {
                    numberView.addConstraint(NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: oldLabel, attribute: .right, multiplier: 1.0, constant: 40.0))
                    numberView.addConstraint(NSLayoutConstraint(item: oldLabel, attribute: .width, relatedBy: .equal, toItem: oldLabel, attribute: .width, multiplier: 1.0, constant: 0.0))
                    numberView.addConstraint(NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: oldLabel, attribute: .width, multiplier: 1.0, constant: 0.0))
                } else {
                    numberView.addConstraint(NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: numberView, attribute: .left, multiplier: 1.0, constant: 0.0))
                }

                if string == self.displayValues![(self.displayValues?.count)!-1] {
                    label.textAlignment = .right
                }



                numberView.addConstraint(NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: numberView, attribute: .top, multiplier: 1.0, constant: 0.0))
                numberView.addConstraint(NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: numberView, attribute: .bottom, multiplier: 1.0, constant: 0.0))

                previousLabel = label
            }

            numberView.addConstraint(NSLayoutConstraint(item: previousLabel!, attribute: .right, relatedBy: .equal, toItem: numberView, attribute: .right, multiplier: 1.0, constant: 0.0))
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        numberView.translatesAutoresizingMaskIntoConstraints = false
        numberView.backgroundColor = UIColor.clear
        numberView.isUserInteractionEnabled = false
        self.addSubview(numberView)

        let views = ["numberView": numberView]

        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[numberView]-8-|", options: .alignAllCenterY, metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[numberView]|", options: .alignAllCenterY, metrics: nil, views: views))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
