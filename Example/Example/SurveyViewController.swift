//
//  SurveyViewController.swift
//  Epifany_Example
//
//  Created by Shawn Murphy on 1/15/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import Foundation
import Epifany


class SurveyViewController: UIViewController, UINavigationControllerDelegate {
    var metaData = [String: Any]()
    var answerPath = [NSNumber]()
    var currentQuestionStartTime: Date?
    var navigationSubController: UINavigationController?
    var currentMainQuestionIndex = -1
    var surveyController: SurveyController?


    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.clear

        let gradientView = GradientView()
        gradientView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(gradientView)

        let surveyStartViewController = SurveyStartViewController()
        surveyStartViewController.startButton.addTarget(self, action: #selector(self.didPressStartButton(sender:)), for: .touchUpInside)

        let navigationController = UINavigationController(rootViewController: surveyStartViewController)
        navigationController.delegate = self
        self.addChildViewController(navigationController)
        self.view.addSubview(navigationController.view)
        navigationController.didMove(toParentViewController: self)
        self.navigationSubController = navigationController
        let views = ["gradientView": gradientView, "navigationController": navigationController.view] as [String: Any]

        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[gradientView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[gradientView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))

        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[navigationController]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[navigationController]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
    }

    @objc func didPressStartButton(sender: UIButton) {
        self.addQuestionController(question: (surveyController?.firstQuestion())!)
    }

    func addQuestionController(question: Question) {
        let controller = self.viewControllerForQuestion(question: question)

        if question.role == "main" {
            self.currentMainQuestionIndex = self.currentMainQuestionIndex + 1
        }
        
        // start time
        self.currentQuestionStartTime = Date()
        controller.nextButton.addTarget(self, action: #selector(self.didPressNextButton(_:)), for: .touchUpInside)
//        controller.titleView.configure(surveyController: self.surveyController!)
//        controller.titleView.setCurrentSection(index: self.currentMainQuestionIndex)
        controller.titleView.setCurrentProgress(progess: (surveyController?.progress)!, total: (surveyController?.numberofQuestions)!)
        self.navigationSubController?.pushViewController(controller, animated: true)
    }

    func viewControllerForQuestion(question: Question) -> SurveyQuestionViewController {
        var controller: SurveyQuestionViewController? = nil
        switch question.type! {
        case .multipleChoice:
            controller = MultipleChoiceViewController()
        case .openAnswer:
            controller = OpenViewController()
        case .mood:
            controller = MoodViewController()
        case .slider:
            controller = SliderViewController()
        case .date:
            controller = DateViewController()
        case .product:
            controller = ProductViewController()
        case .multiselect:
            controller = MultiSelectViewController()
        }

        controller?.currentQuestion = question
        controller?.surveyController = surveyController
        controller?.nextButton.addTarget(self, action: #selector(self.didPressNextButton(_:)), for: .touchUpInside)
        return controller!
    }

    @objc func didPressNextButton(_ sender: AnyObject) {
        if let controller = self.currentQuestionViewController() {
            controller.nextButton.removeTarget(nil, action: nil, for: .allEvents)
            nextQuestion(answer: controller.answer())
        }
    }

    func nextQuestion(answer: AnyObject) {
        var question = surveyController?.nextQuestion(answer: answer)
        if question == nil {
            surveyController?.finishSurvey() { (done) in
                print("FINISHED SURVEY")
                self.dismiss(animated: true, completion: nil)
            }
            return
        }
        addQuestionController(question: question!)
    }


    func currentQuestionViewController() -> SurveyQuestionViewController? {
        return self.navigationSubController?.topViewController as? SurveyQuestionViewController
    }


    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        self.navigationSubController?.navigationBar.layer.removeAllAnimations()
    }

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let navigationBarAnimation = CATransition()
        navigationBarAnimation.duration = 2.0
        navigationBarAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        navigationBarAnimation.type = kCATransitionFade
        navigationBarAnimation.subtype = kCATransitionFade
        navigationBarAnimation.isRemovedOnCompletion = true
    self.navigationSubController?.navigationBar.layer.add(navigationBarAnimation, forKey: nil)
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .pop {
            if toVC is SurveyQuestionViewController {
                (toVC as! SurveyQuestionViewController).nextButton.addTarget(self, action: #selector(self.didPressNextButton(_:)), for: .touchUpInside)
            }
        }
        return nil
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
