//
//  SliderViewController.swift
//  Epifany_Example
//
//  Created by Shawn Murphy on 1/15/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import Epifany

class SliderViewController: SurveyQuestionViewController {
    var sliderQuestion: Question?
    var selectedAnswer: Answer?
    var sliderCell: SliderCell?

    override var currentQuestion: Question? {
        get {
            return sliderQuestion
        }
        set {
            if newValue is Question {
                sliderQuestion = newValue as? Question
                sliderQuestion?.answers?.sort { (obj1, obj2) -> Bool in
                    return obj1.value! < obj2.value!
                }
            } else {
                // TODO: handle error
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.register(SliderCell.self, forCellReuseIdentifier: "sliderCell")
        tableView?.allowsSelection = false
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sliderQuestion?.text
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath as NSIndexPath).section == 0 {
            return tableView.dequeueReusableCell(withIdentifier: "sliderCell")!
        } else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let sliderCell: SliderCell = cell as? SliderCell {
            let firstAnswer: Answer = (self.sliderQuestion?.answers![0])!
            let lastAnswer: Answer = (self.sliderQuestion?.answers![(self.sliderQuestion?.answers!.count)! - 1])!
            sliderCell.leftLabel.text = firstAnswer.text
            sliderCell.rightLabel.text = lastAnswer.text
            sliderCell.sliderView.minimumValue = 0
            sliderCell.sliderView.maximumValue = Float(CGFloat(integerLiteral: (self.sliderQuestion?.answers?.count)! - 1))
            sliderCell.sliderView.addTarget(self, action: #selector(SliderViewController.sliderDidChange(_:)), for: UIControlEvents.valueChanged)
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(sliderTapped(gestureRecognizer:)))
            sliderCell.sliderView.addGestureRecognizer(tapGestureRecognizer)
            self.sliderCell = sliderCell
            var displayValues = [String]()

                        for answer in (self.sliderQuestion?.answers)! {
                            displayValues.append("\(answer.value!)")
                        }
    
                        sliderCell.sliderView.displayValues = displayValues
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SliderCell.height()
    }

    @objc func sliderDidChange(_ sender: UISlider) {
        let position = Int(roundf(sender.value))
        self.selectedAnswer = self.sliderQuestion!.answers?[position]

        if let cell: SliderCell = sender.superview?.superview?.superview as? SliderCell {
            cell.valueView.valueLabel.text = "\(self.selectedAnswer?.value! ?? 0)"
            self.showNextButton(true)
        }
    }

    @objc func sliderTapped(gestureRecognizer: UIGestureRecognizer) {

        let pointTapped: CGPoint = gestureRecognizer.location(in: sliderCell)

        let positionOfSlider: CGPoint = sliderCell!.sliderView.frame.origin
        let widthOfSlider: CGFloat = sliderCell!.sliderView.frame.size.width
        let newValue = ((pointTapped.x - positionOfSlider.x) * CGFloat((sliderCell?.sliderView.maximumValue)!) / widthOfSlider) - 0.6
        sliderCell?.sliderView.setValue(Float(newValue), animated: false)
        sliderCell?.sliderView.setThumbImage(UIImage(named: "firstSlider_button_blue"), for: .normal)
        sliderCell?.valueView.isHidden = false
        sliderDidChange((sliderCell?.sliderView)!)
        sliderCell?.sliderDidChange()
    }

    override func answer() -> AnyObject {
        return [self.selectedAnswer!] as AnyObject
    }

}

