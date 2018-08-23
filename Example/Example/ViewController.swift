//
//  ViewController.swift
//  Epifany
//
//  Created by Murph22 on 01/11/2018.
//  Copyright (c) 2018 Murph22. All rights reserved.
//

import UIKit
import Epifany
import CoreLocation

class ViewController: UIViewController, EpifanyUIDelegate {

    let startButton = UIButton.baseButton()
    var locationButton = UIButton.baseButton()
    var major = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = GradientView()
        startButton.setTitle("Start Survey", for: UIControlState())
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.setTitleColor(UIColor.primaryColor(), for: UIControlState())
        startButton.isEnabled = false
        startButton.addTarget(self, action: #selector(self.didPressStart(sender:)), for: .touchUpInside)
        self.view.addSubview(startButton)

        locationButton.setTitle("Start Survey w/ Location", for: UIControlState())
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        locationButton.setTitleColor(UIColor.primaryColor(), for: UIControlState())
        locationButton.isEnabled = false
        locationButton.addTarget(self, action: #selector(didPressLocation(sender:)), for: .touchUpInside)
        self.view.addSubview(locationButton)
        let views = ["startButton": startButton, "locationButton": locationButton]
        let horizontalConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[startButton]-15-|", options: .alignAllCenterY, metrics: nil, views: views)
        let horizontalConstraint2 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[locationButton]-15-|", options: .alignAllCenterY, metrics: nil, views: views)
        let verticalConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|-300-[startButton]-15-[locationButton]", options: .alignAllCenterX, metrics: nil, views: views)
        NSLayoutConstraint.activate(horizontalConstraint)
        NSLayoutConstraint.activate(horizontalConstraint2)
        NSLayoutConstraint.activate(verticalConstraint)

        

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        EpifanyController.shared.uiDelegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(appClosed), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appClosed), name: NSNotification.Name.UIApplicationWillTerminate, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appOpened), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        updateButtons()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func didPressStart(sender: UIButton) {
        EpifanyController.shared.newSurvey(email: "shawn@getstealz.com", location: nil, mobileOrder: false, completion: { (surveyController) in
            let surveyViewController = SurveyViewController()
            surveyViewController.surveyController = surveyController
            self.present(surveyViewController, animated: true, completion: nil)
        }, failure: { (error) in
            print(error)
        })
    }

    @objc func didPressLocation (sender: UIButton) {
        let location = CLLocation(latitude: 35.7766052, longitude: -78.6454176)
        EpifanyController.shared.newSurvey(email: "shawn@getstealz.com", location: location, mobileOrder: false, completion: { (surveyController) in
            let surveyViewController = SurveyViewController()
            surveyViewController.surveyController = surveyController
            self.present(surveyViewController, animated: true, completion: nil)
        }, failure: { (error) in
            print(error)
        })
    }

    @objc func appClosed() {
        EpifanyController.shared.uiDelegate = nil
    }

    @objc func appOpened() {
        EpifanyController.shared.uiDelegate = self
    }
    
    func didSeeBeacon(available: Bool) {
        self.startButton.isEnabled = available
    }

    func beaconError(error: EpifanyError) {
        if error.message == EpifanyError.noUser {
            updateButtons()
        }

    }

    func updateButtons() {
        EpifanyController.shared.checkForSurvey(email: "shawn@getstealz.com", location: nil, mobileOrder: false, completion: { (available) in
            self.startButton.isEnabled = available
        }, failure: { (error) in
            print(error)
        })
        let location = CLLocation(latitude: 35.7852453, longitude: -78.6880304)
        EpifanyController.shared.checkForSurvey(email: "shawn@getstealz.com", location: location, mobileOrder: false, completion: { (available) in
            self.locationButton.isEnabled = available
        }, failure: { (error) in
            print(error)
        })
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

   

}

