//
//  MoodViewController.swift
//  Epifany_Example
//
//  Created by Shawn Murphy on 1/15/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import Epifany

class MoodViewController: SurveyQuestionViewController {
    var showSecondaryQuestion: Bool = false
    var multipleChoiceQuestion: Question?
    var happyButton: UIButton?
    var sadButton: UIButton?
    var indifferentButton: UIButton?
    var ratingCell: MoodCell?
    let buttonValues: Array<Int> = [-1, 0, 1]
    var buttons: Array<UIButton?> = []

    override var currentQuestion: Question? {
        get {
            return multipleChoiceQuestion
        }
        set {
            if newValue is Question {
                multipleChoiceQuestion = newValue as?Question
            } else {
                // TODO: handle error
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView?.register(MoodCell.self, forCellReuseIdentifier: "moodCell")
        tableView?.separatorStyle = UITableViewCellSeparatorStyle.none
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return self.currentQuestion?.text
        } else {
            return ""
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 0
        }
    }

    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath as NSIndexPath).section == 0 {
            return tableView.dequeueReusableCell(withIdentifier: "moodCell")!
        } else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)  {

        if cell.isKind(of: MoodCell.self) {
            let ratingCell: MoodCell! = cell as? MoodCell
            ratingCell.sadButton.addTarget(self, action: #selector(MoodViewController.didPressMoodButton(_:)), for: UIControlEvents.touchUpInside)
            ratingCell.indifferentButton.addTarget(self, action: #selector(MoodViewController.didPressMoodButton(_:)), for: UIControlEvents.touchUpInside)
            ratingCell.happyButton.addTarget(self, action: #selector(MoodViewController.didPressMoodButton(_:)), for: UIControlEvents.touchUpInside)
            self.buttons.insert(ratingCell.sadButton, at: 0)
            self.buttons.insert(ratingCell.indifferentButton, at: 1)
            self.buttons.insert(ratingCell.happyButton, at: 2)
            self.ratingCell = ratingCell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        if (indexPath as NSIndexPath).section == 0 {
            return 88.0
        } else {
            return 0.0
        }
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let questionHeaderView = QuestionHeaderView()

        if section == 0 {
            questionHeaderView.textLabel.text = self.currentQuestion?.text
        }

        return questionHeaderView
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return QuestionHeaderView.heightForText(self.currentQuestion!.text as! NSString)
        }
        return 0.0
    }

    @objc func didPressMoodButton(_ sender: UIButton) {
        for button in self.buttons {
            button?.alpha = 0.8
            button?.isSelected = false
        }

        sender.alpha = 1.0
        sender.isSelected = true
        self.showNextButton(true)
        self.ratingCell?.pulseButton(sender)
    }

    func selectedAnswer() -> Answer {
        let index = self.buttons.index { $0!.isSelected == true }
        let type: Int = self.buttonValues[index!]
        let answer: Answer = self.multipleChoiceQuestion?.answers!.filter({ (s1) -> Bool in
            let answer: Answer! = s1 as? Answer
            return answer.value! == type
        }).first as! Answer

        return answer
    }

    override func answer() -> AnyObject {
        return self.selectedAnswer() as AnyObject
    }

}

