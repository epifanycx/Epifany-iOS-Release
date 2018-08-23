//
//  DateViewController.swift
//  Epifany_Example
//
//  Created by Shawn Murphy on 1/15/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import Epifany

class DateViewController: SurveyQuestionViewController, UITextViewDelegate {
    var dateAnswerQuestion: Question?
    var textView: UITextView?
    var countLabel: UILabel?
    var dateAnswer = Date()

    override var currentQuestion: Question? {
        get {
            return dateAnswerQuestion
        }
        set {
            if newValue is Question {
                dateAnswerQuestion = newValue as? Question
            } else {
                // TODO: handle error
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView?.register(DateAnswerCell.self, forCellReuseIdentifier: "dateQuestionCell")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        textView?.becomeFirstResponder()
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dateAnswerQuestion?.text
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath as NSIndexPath).section == 0 {
            let dateAnswerCell: DateAnswerCell! = tableView.dequeueReusableCell(withIdentifier: "dateQuestionCell") as? DateAnswerCell
            self.textView = dateAnswerCell.textView
            self.textView?.delegate = self

            dateAnswerCell.datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControlEvents.valueChanged)

            return dateAnswerCell
        } else {
            return UITableViewCell()
        }
    }

    @objc func datePickerValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle =  DateFormatter.Style.none

        self.dateAnswer = sender.date
        self.textView?.text = dateFormatter.string(from: sender.date)

        self.showNextButton(true)
    }

    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        return 30.0
    }

    override func answer() -> AnyObject {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        return dateFormatter.string(from: self.dateAnswer) as AnyObject
    }

}

