//
//  SurveyStartViewController.swift
//  Epifany_Example
//
//  Created by Shawn Murphy on 1/15/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import Epifany

class SurveyStartViewController: UIViewController {
    let titleLabel: UILabel = UILabel()
    let businessInfoView = SurveyStartInfoView()
    let pointsInfoView = SurveyStartInfoView()
    let timeInfoView = SurveyStartInfoView()
    let descriptionLabel = UILabel()
    let startButton = UIButton.baseButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.clear

//        self.navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "ic_back_normal"), landscapeImagePhone: nil, style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.didPressBackButton(_:)))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "ic_back_normal"), style: .plain, target: self, action: #selector(didPressBackButton(sender:)))
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textColor = UIColor.white
        titleLabel.text = NSLocalizedString("Leave Feedback", comment: "")
        view.addSubview(titleLabel)

        businessInfoView.iconBackgroundImageView.image = UIImage(named: "surveyIntro_icon_logo")
        businessInfoView.iconImageView.layer.cornerRadius = 14.0
        businessInfoView.iconImageView.clipsToBounds = true
        businessInfoView.titleLabel.text = NSLocalizedString("FOR:", comment: "")
        businessInfoView.titleLabel.textColor = UIColor.white
        businessInfoView.descriptionLabel.textColor = UIColor.white
        businessInfoView.iconImageView.image = UIImage(named: "")
        businessInfoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(businessInfoView)

        pointsInfoView.titleLabel.text = NSLocalizedString("TO EARN:", comment: "")
        pointsInfoView.titleLabel.textColor = UIColor.white
        pointsInfoView.iconImageView.image = UIImage(named: "")
        pointsInfoView.iconImageView.image = UIImage(named: "surveyIntro_icon_present")
        pointsInfoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pointsInfoView)

        timeInfoView.titleLabel.text = NSLocalizedString("IT WILL TAKE YOU:", comment: "")
        timeInfoView.titleLabel.textColor = UIColor.white
        timeInfoView.iconImageView.image = UIImage(named: "")
        timeInfoView.iconImageView.image = UIImage(named: "surveyIntro_icon_clock")
        timeInfoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timeInfoView)

        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textColor = UIColor.white
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = NSTextAlignment.center
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.text = NSLocalizedString("Tell them what you think! Your honest feedback is important to their team & will help them improve your next visit.", comment: "")
        view.addSubview(descriptionLabel)

        startButton.setTitle(NSLocalizedString("Get Started!", comment: ""), for: UIControlState())
        startButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(startButton)

        let views = ["titleLabel": titleLabel, "businessInfoView": businessInfoView,
                     "pointsInfoView": pointsInfoView, "timeInfoView": timeInfoView,
                     "descriptionLabel": descriptionLabel, "startButton": startButton] as [String: Any]

        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-25-[titleLabel]-25-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-25-[businessInfoView]-25-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-25-[pointsInfoView]-25-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-25-[timeInfoView]-25-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-25-[descriptionLabel]-25-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[startButton]-15-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))

        view.addConstraint(NSLayoutConstraint(item: startButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0))

        if UIScreen.main.bounds.size.height <= 480.0 {
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[titleLabel][businessInfoView(==81)][pointsInfoView(==81)][timeInfoView(==81)]-10-[descriptionLabel]-10-[startButton(==45)]-10-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        } else {
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[titleLabel]-8-[businessInfoView(==81)][pointsInfoView(==81)][timeInfoView(==81)]-29-[descriptionLabel]-34-[startButton(==45)]-(>=20)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        edgesForExtendedLayout = []
        self.configure()
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    @objc func didPressBackButton(_ sender: Any) {
        if navigationController != nil {
            navigationController?.popViewController(animated: true)
        }
    }

    func configure() {
            businessInfoView.descriptionLabel.text = "Mcdonalds"
//            businessInfoView.iconImageView.setImageWith(URLRequest(url: URL(string: venue.logoDetailUrl!)!), placeholderImage: nil, success: { (request, response, image) in
//                self.businessInfoView.iconImageView.image = image
//            }) { (request, response, error) in
//                //
//            }

//        if let survey = survey {
//            pointsInfoView.descriptionLabel.text = NSString.localizedStringWithFormat("%@", survey.points!) as String
//            timeInfoView.descriptionLabel.text = survey.estimatedTime
//        }
    }

    @objc func didPressBackButton(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
