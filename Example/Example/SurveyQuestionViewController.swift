//
//  SurveyQuestionViewController.swift
//  Epifany_Example
//
//  Created by Shawn Murphy on 1/15/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import Epifany

class SurveyQuestionViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    var currentQuestion: Question?
    var titleView = SurveyTopView()
    let nextButton = UIButton.baseButton()
    var lastBeacon = 0
    var autoAnswer = false
    weak var tableView: UITableView?
    var surveyController: SurveyController?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.clear
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "ic_back_normal"), style: .plain, target: self, action: #selector(didPressBackButton(sender:)))

        self.titleView.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width - 60.0, height: 44.0)
        self.navigationItem.titleView = self.titleView

        let gradient = GradientView()
        gradient.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(gradient)


        let tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.grouped)
        tableView.backgroundColor = UIColor.clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.view.addSubview(tableView)
        self.tableView = tableView
//        self.scrollViewToAdjustForKeyboard = tableView


        let footerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: 109.0))
        tableView.tableFooterView = footerView

        nextButton.setTitle("", for: UIControlState())
        nextButton.backgroundColor = UIColor.clear
        nextButton.alpha = 0
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setContentHuggingPriority(UILayoutPriority.defaultLow, for: UILayoutConstraintAxis.horizontal)

        footerView.addSubview(nextButton)

        let views = ["tableView": tableView, "gradient": gradient, "nextButton": nextButton, "view": view] as [String: Any]
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[gradient]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[gradient]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableView(==view)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))

        footerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[nextButton]-15-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        footerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-40-[nextButton(==44)]-25-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let questionHeaderView = QuestionHeaderView()
        questionHeaderView.textLabel.text = self.currentQuestion?.text
        return questionHeaderView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return QuestionHeaderView.heightForText(self.currentQuestion!.text as! NSString)
    }

    func showNextButton(_ show: Bool) {
        var nextButtonTitle = NSLocalizedString("Next", comment: "")
        if show {
            self.nextButton.setTitle(nextButtonTitle, for: UIControlState())
            UIView.animate(withDuration: 0.3, animations: { () in
                self.nextButton.alpha = 1.0
            }, completion: nil)
            self.nextButton.isHidden = false
        } else {
            self.nextButton.alpha = 0
        }
    }

    func answer() -> AnyObject {
        return "" as AnyObject
    }
    
    @objc func didPressBackButton(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        surveyController?.removeLastResponse()
    }

    func didPressHelpButton(sender: AnyObject?) {

    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

