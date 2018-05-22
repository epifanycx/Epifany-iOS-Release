<p>
    <img height="81" width="500" src="epifany_logo_main_green.png"/>
</p>

---

[![Maintainability](https://api.codeclimate.com/v1/badges/f5f9372cf31d0a8f989e/maintainability)](https://codeclimate.com/repos/5aec7a1f021c8602eb0001c5/maintainability)
[![CircleCI](https://circleci.com/gh/stealzinc/Epifany-iOS.svg?style=svg&circle-token=9fc5b2ca1383a7d6d3df19237c37a29ab08d85cd)](https://circleci.com/gh/stealzinc/Epifany-iOS)
[![Version](https://img.shields.io/cocoapods/v/Epifany.svg?style=flat)](http://cocoapods.org/pods/Epifany)
[![License](https://img.shields.io/cocoapods/l/Epifany.svg?style=flat)](http://cocoapods.org/pods/Epifany)
[![Platform](https://img.shields.io/cocoapods/p/Epifany.svg?style=flat)](http://cocoapods.org/pods/Epifany)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

# Table of Contents
1. [Requirements](#requirements)
2. [How it Works](#how-it-works)
3. [Installation](#installation)
3. [Usage](#usage)
    1. [Survey](#survey)
        1. [Check for Survey](#check-for-survey)
        2. [Start a Survey](#start-a-survey)
        3. [Finish a Question](#finish-a-question-or-survey)
        4. [Check Question Type](#check-question-type)
        5. [Product Question Tool](#product-question-tool)
        6. [Open Question Tool](#open-question-tool)
    2. [Beacons](#beacons)
        1. [Start Beacon Monitoring](#start-beacon-monitoring)
        2. [Adding a Delegate for UI Updates](#adding-a-delegate-for-ui-updates)
        3. [Adding Background Delegate for Beacon Hits](#adding-background-delegate-for-beacon-hits)

# Requirements

 - Location Permission is required to range beacons
 - Plist Permissions
    - Privacy - Bluetooth Peripheral Usage
    - Privacy - Location Always and When In Use Usage Description


# How it Works
Epifany listens for beacons (using bluetooth) in the background to verify the user is
at a venue. Once a beacon is seen, Epifany will notify your app through
a `EpifanyBackgroundDelegate` in order to produce a notification. This will allow
the user to take a survey. Once a survey is started you will use `EpifanySurvey`
to navigate through it.

**What if a user’s Bluetooth is turned off?** Don't Sweat it, you can use the user's current
location as a fall back.

# Installation

Epifany is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Epifany'
```

# Usage

Initialize SDK from your AppDelegate.  We require an appToken and appId
that you can find on your dashboard or get from us.
```swift
EpifanyController.shared.setUp(token: "yourAppToken", id: yourAppId)
```
## Survey

### Check for Survey
This will be used to communicate with our server to see if there is a survey available.
The user's `email` is required to determine their survey status.
The user's `location` is used as a fallback if we have not seen a beacon.
The `mobileOrder` flag is used to let us know the user used mobile ordering.
The `completion` block allows you to update your UI when there is a survey.
```swift
EpifanyController.shared.checkForSurvey(email: "userEmail", 
location: CLLocation?, mobileOrder: Bool?, completion: { (available) in
    // Change start of start survey button
    }, failure: { (error) in
    // Handle error message
})
```
### Start a Survey
This is used to get a new survey from our server.
The user's `location` is used as a fallback if we have not seen a beacon.
The `mobileOrder` flag is used to let us know the user used mobile ordering.
The `completion` will return an EpifanySurvey object that helps you navigate
and interact with the survey.
```swift
EpifanyController.shared.newSurvey(email: "userEmail", 
location: CLLocation?, mobileOrder: Bool? completion: { (surveyController) in
    let viewController = ViewController()
    viewController.surveyController = surveyController
    self.present(viewController, animated: true, completion: nil)
    }, failure : { (error) in
    // Handle error message
})
```
### Finish a Question or Survey
This is used to get the next question or end the survey. This function takes on of three
parameters (String, Answer, \[Answer\]). The function will return the next question
that should be displayed to the user. If the returned object is nil
than the user is at the end of the survey, and you should call
`surveyController.finishSurvey()`. The callback will let you know when we finished
uploading to our server.
```swift
    // answer is either a String, Answer, or [Answer]
    if let question = surveyContorller.nextQuestion(answer: answer) {
    // Start next question
    } else {
    // Finish survey flow
    surveyController?.finishSurvey() { (done) in
        print("FINISHED SURVEY")
        self.dismiss(animated: true, completion: nil)
    }
    }
```

### Check Question Type
The question type is used for different UI desgins and user interactions.
```swift
    question.type
```
Every question will have one of the following types:
```
1. "MoodQuestion"
    2. "MultipleChoiceQuestion"
    3. "SliderQuestion"
    4. "DateQuestion"
    5. "ProductQuestion"
    6. "OpenQuestion"
```

### Product Question Tool
This tool is used to help populate answers when the user selects a
value meal or combo on a product question. For Example: if the user selects
"Cheeseburger Combo" this method will return a list with the objects,
"Cheeseburger", "Fries", & "Drink".
```swift
// Whenever you select an answer pass it though our 
// check to make sure it is not a bundle/group of 
// answers
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // Check answer may return an array of answers, this is for handling
    // value meals or other combo meals, or returns the current selection
    // if not a bundle.
    let answers = surveyController.checkAnswer(answer: answer)
    if answers.count > 1 {
        // Select the various answers
    } else {
        // Select the current answer
    }
}
```

### Open Question Tool
This tool is used to simplify updating gibberish, hints, & character limit reached.
The `listener` is only fired when the state of gibberish, hints, or
character limit reached has changed.
```swift
 
 class OpenViewController: UITextDelegate, EpifanyTextDelegate {
    //...
    func textViewDidChange(_ textView: UITextView) {
        // This will fire EpifanyTextDelegate if any
        // of the states change
        surveyController?.textUpdated(string: textView.text)
    }
    
    // ...
    func onGibberish(gibberish: Bool) {
        // Handle gibberish
    }
    
    func onHintChanged(hint: String) {
        // Handle hint
    }
    
    func onCharacterLimit(reached: Bool) {
        // Hanlde Character limit reached
    }
 }
```
![](hint.gif) ![](gibberish.gif)

## Beacons

### Start Beacon Monitoring
This will allow the user to range beacons. Call this after you gain location permissons.
```swift
    EpifanyController.shared.startMonitoringBeacons()
```

### Adding a Delegate for UI Updates
This `delegate` is used to udate the UI when the user see's a beacon.

```swift
class ViewContoller: EpifanyUiDelegate {
   // ...

    func didSeeBeacon(available: Bool) {
        // Update UI to reflect survey available
    }
    
    func beaconError(error: String) {
        // Handle beacon error
        if error == "No User Email" {
            EpifanyController.checkForSurvey(email: "userEmail", ...)
            ...
        }
    }
}

}
```

### Adding Background Delegate for Beacon Hits
This `delegate` is used in the background to allow you to send the user
a local notification when the user see's a beacon.
```swift
class AppDelegate: EpifanyBackgroundDelegate {
    // ...
    func didSeeBeacon(available: Bool) {
        // Send notification to user
    }
    
    func beaconError(error: String) {
        // Handle beacon error
        if error == "No User Email" {
            EpifanyController.checkForSurvey(email: "userEmail", ...)
    //        ...
        }
    }
}
```
## Author

Shawn Murphy,  shawn.murphy@epifany.com

## License

Epifany is available under the MIT license. See the LICENSE file for more info.
