//
//  SurveyTopView.swift
//  Epifany_Example
//
//  Created by Shawn Murphy on 1/15/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import Epifany

class SurveyTopView: UIView {
    let progressView = UIProgressView()
    let progressText = UILabel()
    var sectionViews = [UIView]()
    var selectedIndex = -1

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.progressView.translatesAutoresizingMaskIntoConstraints = false
        self.progressView.progressTintColor = .white
        self.progressView.backgroundColor = UIColor.transparentColor()
        self.progressView.progressViewStyle = .bar
        self.progressView.layer.cornerRadius = 5.0
        self.progressView.layer.sublayers![1].cornerRadius = 5.0
        self.progressView.subviews[1].clipsToBounds = true
        self.addSubview(self.progressView)

        self.progressText.translatesAutoresizingMaskIntoConstraints = false
        self.progressText.numberOfLines = 0
        self.progressText.textColor = UIColor.white
        self.progressText.textAlignment = NSTextAlignment.center
        self.addSubview(self.progressText)

        let views = [ "progressView": self.progressView, "progressText": self.progressText] as [String: Any]
        let metrics = [ "width": UIScreen.main.bounds.width - 140]

        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[progressView(==11)]", options: .alignAllCenterX, metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[progressText]|", options: [], metrics: nil, views: views))
        self.addConstraint(NSLayoutConstraint(item: progressView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: progressText, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[progressText]-15-[progressView(==width)]-5-|", options: .alignAllCenterY, metrics: metrics, views: views))

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(surveyController: SurveyController) {
//        var lastView: UIView? = nil
//        if let count: Int =  surveyController.numberofQuestions {
//
//            let totalWidth = CGFloat(60*count+6*(count-1))
//
//            var availableWidth = UIScreen.main.bounds.width - 95
//            var width = availableWidth - totalWidth
//            if totalWidth > availableWidth {
//                width = 10
//            }
//            for _ in 0...Int(count - 1) {
//                let sectionView = UIView()
//                sectionView.translatesAutoresizingMaskIntoConstraints = false
//                sectionView.backgroundColor = UIColor.white
//                sectionView.layer.cornerRadius = 3.0
//                sectionView.alpha = 0.3
//                self.addSubview(sectionView)
//                self.sectionViews.append(sectionView)
//
//
//                if lastView == nil {
//                    self.addConstraint(NSLayoutConstraint(item: sectionView, attribute: .left, relatedBy: .equal, toItem: progressView, attribute: .left, multiplier: 1.0, constant: width/2))
//                } else {
//                    self.addConstraint(NSLayoutConstraint(item: sectionView, attribute: .left, relatedBy: .equal, toItem: lastView, attribute: .right, multiplier: 1.0, constant: 6.0))
//                    self.addConstraint(NSLayoutConstraint(item: sectionView, attribute: .width, relatedBy: .equal, toItem: lastView, attribute: .width, multiplier: 1.0, constant: 0.0))
//                }
//                self.addConstraint(NSLayoutConstraint(item: sectionView, attribute: .top, relatedBy: .equal, toItem: self.progressView, attribute: .top, multiplier: 1.0, constant: 0.0))
//                self.addConstraint(NSLayoutConstraint(item: sectionView, attribute: .bottom, relatedBy: .equal, toItem: self.progressView, attribute: .bottom, multiplier: 1.0, constant: 0.0))
//
//                lastView = sectionView
//            }
//
//            if let lastView = lastView {
//
//                self.addConstraint(NSLayoutConstraint(item: lastView, attribute: .right, relatedBy: .equal, toItem: self.progressView, attribute: .right, multiplier: 1.0, constant: -width/2))
//            }
//        }
    }

    func sectionView(on: Bool, index: Int) {
        let sectionView = self.sectionViews[index]
        if on {
            sectionView.alpha = 1.0
        } else {
            sectionView.alpha = 0.3
        }
    }

    func setCurrentSection(index: Int) {
        self.selectedIndex = index
        for sectionView in self.sectionViews {
            let sectionViewIndex = sectionViews.index(of: sectionView)
            if sectionViewIndex! <= index {
                sectionView.alpha = 1.0
            } else {
                sectionView.alpha = 0.3
            }
        }
    }

    func setCurrentProgress(progess: Int, total: Int) {
        let currentProgess = Float(Float(progess) / Float(total))
        progressText.text = "\(progess)/\(total)"
        progressView.setProgress(currentProgess, animated: false)
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let width = self.progressView.bounds.size.width / CGFloat(self.sectionViews.count)
        for view in self.sectionViews {
              view.layer.cornerRadius = self.progressView.bounds.size.height / 2.0
            if width > 60.0 {
                view.bounds.size.width = 60.0
            } else {
                view.bounds.size.width = width-6
            }
        }
    }

}

