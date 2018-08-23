//
//  MultiSelectViewController.swift
//  Epifany_Example
//
//  Created by Shawn Murphy on 8/8/18.
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

fileprivate func > <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}


class MultiSelectViewController: SurveyQuestionViewController {
    var orderTypeQuestion = false
    var answers = [Answer]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.register(AnswerCell.self, forCellReuseIdentifier: "answerCell")
        tableView?.allowsMultipleSelection = true

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return currentQuestion?.text
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (currentQuestion?.answers!.count)!
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        self.showNextButton(true)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath as NSIndexPath).section == 0 {
            return tableView.dequeueReusableCell(withIdentifier: "answerCell")!
        } else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.isKind(of: AnswerCell.self) {
            let answer: Answer! = self.currentQuestion?.answers![(indexPath as NSIndexPath).row]
            let answerCell: AnswerCell! = cell as? AnswerCell
            answerCell.answerLabel.text = answer.text

            if (indexPath as NSIndexPath).row == 0 && self.currentQuestion?.answers?.count > 1 {
                answerCell.position = AnswerCellPosition.top
            } else if (indexPath as NSIndexPath).row == (self.currentQuestion?.answers?.count)! - 1 && self.currentQuestion?.answers?.count > 1 {
                answerCell.position = AnswerCellPosition.bottom
            } else {
                answerCell.position = AnswerCellPosition.middle
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let answer: Answer! = (self.currentQuestion?.answers![(indexPath as NSIndexPath).row])!
        let string: NSString = answer.text as! NSString
        return AnswerCell.heightWithAnswer(string)
    }

    override func answer() -> AnyObject {
        var answers = [Answer]()
        for path in (self.tableView?.indexPathsForSelectedRows)! {
            answers.append((self.currentQuestion?.answers![path.row])!)
        }
        return answers as AnyObject
    }

}


