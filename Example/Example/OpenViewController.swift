//
//  OpenViewController.swift
//  Epifany_Example
//
//  Created by Shawn Murphy on 1/15/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import Epifany

fileprivate func < <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

fileprivate func >= <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l >= r
    default:
        return !(lhs < rhs)
    }
}


class OpenViewController: SurveyQuestionViewController, UITextViewDelegate, EpifanyTextDelegate {
    var openAnswerQuestion: Question?
    let label = UILabel()
    let textField = UITextView()
    let characterLabel = UILabel()
    let labelBackgroundView = UIView()
    let textFieldBackgroundView = UIView()
    let bottomView = UIView()
    let countLabel = UILabel()
    var bottomViewConstraint = NSLayoutConstraint()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var currentQuestion: Question? {
        get {
            return openAnswerQuestion
        }
        set {
            if newValue is Question {
                openAnswerQuestion = newValue as? Question
            } else {
                // TODO: handle error
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.register(OpenCell.self, forCellReuseIdentifier: "openQuestionCell")
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.backgroundColor = UIColor.clear
        self.view.addSubview(bottomView)

        labelBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        labelBackgroundView.isHidden = true
        bottomView.addSubview(labelBackgroundView)

        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        labelBackgroundView.addSubview(label)

        let footerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: 79.0))
        tableView?.tableFooterView = footerView

        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.alpha = 0.5
        countLabel.textAlignment = NSTextAlignment.center
        countLabel.textColor = UIColor.white
        countLabel.text = String(format: "Minimum of %d characters in length", (self.openAnswerQuestion?.characterLimit)!)
        footerView.addSubview(countLabel)

        setUpTextField()

        setUpConstraints()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.textField.becomeFirstResponder()
    }

    func setUpTextField() {
        textFieldBackgroundView.backgroundColor = UIColor.white
        textFieldBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(textFieldBackgroundView)

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = NSTextAlignment.left
        textField.delegate = self
        textField.isScrollEnabled = false
        textFieldBackgroundView.addSubview(textField)

        surveyController?.textDelegate = self

        nextButton.setImage(UIImage(), for: .disabled)
        nextButton.setImage(UIImage(imageLiteralResourceName: "ic_send_active"), for: .normal)
        nextButton.setBackgroundImage(nil, for: .normal)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.isEnabled = false
        nextButton.alpha = 1.0
        nextButton.contentEdgeInsets = UIEdgeInsets.zero
        bottomView.addSubview(nextButton)

        characterLabel.translatesAutoresizingMaskIntoConstraints = false
        characterLabel.textAlignment = NSTextAlignment.center
        characterLabel.text = String(format: "0/%d ", (self.openAnswerQuestion?.characterLimit)!)
        bottomView.addSubview(characterLabel)
    }

    func setUpConstraints() {
        let views = [ "countLabel": countLabel, "labelBackgroundView": labelBackgroundView, "textFieldBackgroundView": textFieldBackgroundView, "label": label, "textField": textField, "bottomView": bottomView, "nextButton": nextButton, "characterLabel": characterLabel]

        tableView?.tableFooterView?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[countLabel]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        tableView?.tableFooterView?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[countLabel]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        bottomView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[labelBackgroundView][textFieldBackgroundView(>=52)]|", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: views))
        bottomView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[labelBackgroundView]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        bottomView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[nextButton(==30)]-11-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        bottomView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[characterLabel(==30)]-11-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        bottomView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[labelBackgroundView]|", options: NSLayoutFormatOptions.alignAllLastBaseline, metrics: nil, views: views))

        bottomView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[nextButton(==30)]-5-|", options: NSLayoutFormatOptions.alignAllLastBaseline, metrics: nil, views: views))
        bottomView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[characterLabel]-5-|", options: NSLayoutFormatOptions.alignAllLastBaseline, metrics: nil, views: views))
        bottomView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[textFieldBackgroundView]|", options: NSLayoutFormatOptions.alignAllLastBaseline, metrics: nil, views: views))

        labelBackgroundView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-15-[label]-15-|", options: NSLayoutFormatOptions.alignAllLastBaseline, metrics: nil, views: views))
        labelBackgroundView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[label]-5-|", options: NSLayoutFormatOptions.alignAllLastBaseline, metrics: nil, views: views))

        textFieldBackgroundView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[textField]-40-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        textFieldBackgroundView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[textField]-10-|", options: NSLayoutFormatOptions.alignAllLastBaseline, metrics: nil, views: views))

        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[bottomView]|", options: NSLayoutFormatOptions.alignAllLastBaseline, metrics: nil, views: views))

        bottomViewConstraint = NSLayoutConstraint(item: bottomView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        self.view.addConstraint(bottomViewConstraint)
    }

    func textViewDidChange(_ textView: UITextView) {
        characterLabel.text = String(format: "%d/%d ", (textView.text?.characters.count)!, (self.openAnswerQuestion?.characterLimit)!)
        surveyController?.textUpdated(string: textView.text)
    }

    var limitReached = false
    var gibberish = false
    func onGibberish(gibberish: Bool) {
        self.gibberish = gibberish
        if gibberish {
            label.text = "Please clarify your answer"
            labelBackgroundView.backgroundColor = UIColor.red
            labelBackgroundView.isHidden = false
            characterLabel.isHidden = false
            self.showNextButton(false)
        } else {
            labelBackgroundView.isHidden = true
            if limitReached {
                self.showNextButton(true)
                characterLabel.isHidden = true
            }
        }
    }

    func onHintChanged(hint: String) {
        if hint != "" {
            labelBackgroundView.backgroundColor = UIColor.hintColor()
            labelBackgroundView.isHidden = false
            label.text = hint
        } else {
            labelBackgroundView.isHidden = true
        }
    }

    func onCharacterLimit(reached: Bool) {
        limitReached = reached
        if limitReached && !gibberish {
            self.showNextButton(true)
            characterLabel.isHidden = true
        } else {
             self.showNextButton(false)
            characterLabel.isHidden = false
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        return 88.0
    }

    override func answer() -> AnyObject {
        return self.textField.text as AnyObject
    }

    @objc func keyboardWillShow(_ notification: Notification!) {
        if let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            bottomViewConstraint.constant = -keyboardFrame.cgRectValue.height
        }
    }

    @objc func keyboardWillHide(_ notification: Notification!) {
        bottomViewConstraint.constant = 0
    }

    override func showNextButton(_ show: Bool) {
        if show {
            self.nextButton.isEnabled = true
        } else {
            self.nextButton.isEnabled = false
        }
    }

}

