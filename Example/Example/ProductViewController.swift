//
//  ProductViewController.swift
//  Epifany_Example
//
//  Created by Shawn Murphy on 1/15/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import Epifany

class ProductViewController: SurveyQuestionViewController, RKTagsViewDelegate, UITextFieldDelegate {
    let tagsView = RKTagsView()
    let answerTableView = UITableView(frame: .zero, style: .plain)
    let dataSource = STZTagDataSource()
    let label = UILabel()
    let labelBackgroundView = UIView()
    let textFieldBackgroundView = UIView()
    let bottomView = UIView()
    var bottomViewConstraint = NSLayoutConstraint()
    var productQuestion: Question?
    var answerTableViewHeightConstraint: NSLayoutConstraint?

    override var currentQuestion: Question? {
        get {
            return productQuestion
        }
        set {
            if newValue is Question {
                productQuestion = newValue as? Question
            } else {
                // TODO: handle error
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        self.dataSource.delegate = self

        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.backgroundColor = UIColor.white
        self.view.addSubview(bottomView)

        labelBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        labelBackgroundView.backgroundColor = UIColor.hintColor()
        bottomView.addSubview(labelBackgroundView)

        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.white
        label.text = "Type below and select from the list"
        labelBackgroundView.addSubview(label)

        setUpTagsView()
        
        setUpConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tagsView.textField.becomeFirstResponder()
    }

    func setUpTagsView() {
        textFieldBackgroundView.backgroundColor = UIColor.clear
        textFieldBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(textFieldBackgroundView)

        tagsView.backgroundColor = UIColor.white
        tagsView.delegate = self
        tagsView.textField.textColor = UIColor.black
        tagsView.textFieldHeight = 30.0
        tagsView.textField.autocorrectionType = .no
        tagsView.translatesAutoresizingMaskIntoConstraints = false
        tagsView.textField.addTarget(self, action: #selector(ProductViewController.textFieldDidUpdate), for: .editingChanged)
        tagsView.selectBeforeRemoveOnDeleteBackward = false

        textFieldBackgroundView.addSubview(tagsView)

        answerTableView.translatesAutoresizingMaskIntoConstraints = false
        answerTableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "tagCell")
        answerTableView.delegate = dataSource
        answerTableView.dataSource = dataSource
        bottomView.addSubview(answerTableView)

        nextButton.setImage(UIImage(imageLiteralResourceName: "ic_send_normal"), for: .disabled)
        nextButton.setImage(UIImage(imageLiteralResourceName: "ic_send_active"), for: .normal)
        nextButton.setBackgroundImage(nil, for: .normal)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.isEnabled = false
        nextButton.alpha = 1.0
        nextButton.contentEdgeInsets = UIEdgeInsets.zero
        bottomView.addSubview(nextButton)
    }

    func setUpConstraints() {
        let views = [ "textFieldBackgroundView": textFieldBackgroundView, "tagsView": tagsView, "bottomView": bottomView, "nextButton": nextButton, "answerTableView": answerTableView, "labelBackgroundView": labelBackgroundView, "label": label ]

        bottomView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[labelBackgroundView][textFieldBackgroundView]|", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: views))
        bottomView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[labelBackgroundView]|", options: NSLayoutFormatOptions.alignAllLastBaseline, metrics: nil, views: views))
        bottomView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[answerTableView][textFieldBackgroundView]|", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: views))
        bottomView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[answerTableView]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        bottomView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[nextButton(==30)]-10-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        bottomView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[nextButton(==30)]-5-|", options: NSLayoutFormatOptions.alignAllLastBaseline, metrics: nil, views: views))
        bottomView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[answerTableView]|", options: NSLayoutFormatOptions.alignAllLastBaseline, metrics: nil, views: views))

        bottomView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[textFieldBackgroundView]|", options: NSLayoutFormatOptions.alignAllLastBaseline, metrics: nil, views: views))

        labelBackgroundView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-15-[label]-15-|", options: NSLayoutFormatOptions.alignAllLastBaseline, metrics: nil, views: views))
        labelBackgroundView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[label]-5-|", options: NSLayoutFormatOptions.alignAllLastBaseline, metrics: nil, views: views))

        textFieldBackgroundView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[tagsView]-40-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        textFieldBackgroundView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[tagsView]-10-|", options: NSLayoutFormatOptions.alignAllLastBaseline, metrics: nil, views: views))

        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[bottomView]|", options: NSLayoutFormatOptions.alignAllLastBaseline, metrics: nil, views: views))

        bottomViewConstraint = NSLayoutConstraint(item: bottomView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        self.view.addConstraint(bottomViewConstraint)

        self.answerTableViewHeightConstraint = NSLayoutConstraint(item: answerTableView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0.0)
        self.answerTableViewHeightConstraint?.priority = UILayoutPriority.defaultLow
        bottomView.addConstraint(self.answerTableViewHeightConstraint!)

        let constraint = NSLayoutConstraint(item: answerTableView, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: self.topLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        constraint.priority = UILayoutPriority.required
        self.view.addConstraint(constraint)
    }

    @objc func keyboardWillShow(_ notification: Notification!) {
//        super.keyboardWillShow(notification)

        if let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            bottomViewConstraint.constant = -keyboardFrame.cgRectValue.height
        }
    }

    func tagsView(_ tagsView: RKTagsView, shouldAddTagWithText text: String) -> Bool {
        return false
    }

    func tagsViewDidChange(_ tagsView: RKTagsView) {

    }

    func tagsView(_ tagsView: RKTagsView, buttonForTagAt index: Int) -> UIButton {
        let tagText = tagsView.tags[index]
        let button = UIButton(type: .custom)
        button.setImage(UIImage(imageLiteralResourceName: "tag_icon_close_normal"), for: .normal)
        button.backgroundColor = UIColor.hintColor()
        button.setTitle(tagText, for: .normal)
        button.imageEdgeInsets = UIEdgeInsetsMake(0.0, -5.0, 0.0, 0.0)
        button.titleLabel?.textColor = UIColor.black
        button.layer.cornerRadius = 4.0
        button.contentEdgeInsets = UIEdgeInsetsMake(5.0, 10.0, 5.0, 10.0)
        return button
    }

    func tagsView(_ tagsView: RKTagsView, shouldSelectTagAt index: Int) -> Bool {
        tagsView.removeTag(at: index)
        updateButton()
        return false
    }

    @objc func textFieldDidUpdate() {
        let text = self.tagsView.textField.text

        var items = [String]()

        for answer: Answer in (self.productQuestion?.answers)! {
            if (answer.text?.lowercased().contains(text!.lowercased()))! && !tagsView.tags.contains(answer.text!) {
                items.append(answer.text!)
            }
        }

        self.dataSource.items = items
        self.dataSource.searchText = text

        self.answerTableView.reloadData()

        let count = items.count

        self.answerTableViewHeightConstraint?.constant = CGFloat(count) * 44.0

        updateButton()
    }

    override func showNextButton(_ show: Bool) {
        if show {
            self.nextButton.isEnabled = true
        } else {
            self.nextButton.isEnabled = false
        }
    }

    override func answer() -> AnyObject {
        var answers = [Answer]()
        for tag in self.tagsView.tags {
            if let found = self.productQuestion!.answers?.first(where: { (answer) -> Bool in
                return answer.text == tag
            }) {
                answers.append(found)
            }
        }
        return answers as AnyObject
    }

    func updateButton() {
        if tagsView.tags.count > 0 {
            self.showNextButton(true)
            labelBackgroundView.isHidden = true
        } else {
            self.showNextButton(false)
            labelBackgroundView.isHidden = false
        }
    }

    class STZTagDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
        var items = [String]()
        var searchText: String?
        weak var delegate: ProductViewController?

        public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "tagCell", for: indexPath)
            cell.textLabel?.textColor = UIColor.black

            let attrString = NSMutableAttributedString(string: self.items[indexPath.row])
            let string = attrString.string.lowercased() as NSString
            let range = string.range(of: (searchText?.lowercased())!)
            attrString.addAttributes([NSAttributedStringKey.foregroundColor: UIColor.hintColor()], range: range)
            cell.textLabel?.attributedText = attrString

            return cell
        }

        public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return items.count
        }

        public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let item = self.items[indexPath.row]
            self.delegate?.tagsView.textField.text = nil

            self.delegate?.textFieldDidUpdate()
            var answer: Answer?
            for a in (self.delegate?.currentQuestion?.answers)! {
                if a.text == item {
                    answer = a
                    break
                }
            }
            let answersTemp = self.delegate?.surveyController?.checkAnswer(answer: answer!)
            if answersTemp!.count > 1 {
                for a2 in answersTemp! {
                    if !(self.delegate?.tagsView.tags.contains(a2.text!))! {
                        self.delegate?.tagsView.addTag(a2.text!)
                    }
                }
            } else {
                self.delegate?.tagsView.addTag(item)
            }
            self.delegate?.textFieldDidUpdate()

        }

    }

}

