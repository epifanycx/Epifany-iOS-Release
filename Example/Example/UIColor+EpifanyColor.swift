//
//  UIColor+EpifanyColor.swift
//  Epifany_Example
//
//  Created by Shawn Murphy on 5/11/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    class func primaryColor() -> UIColor {
        return UIColor(red: 0.0/255.0, green: 128.0/255.0, blue: 128.0/255.0, alpha: 1.0)
    }

    class func gradientBottom() -> UIColor {
        return UIColor(red: 0.0/255.0, green: 176.0/255.0, blue: 193.0/255.0, alpha: 1.0)
    }

    class func transparentColor() -> UIColor {
        return UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.25)
    }

    class func hintColor() -> UIColor {
//        rgb(30,157,225)
        return UIColor(red: 30.0/255.0, green: 157.0/255.0, blue: 225.0/255.0, alpha: 1.0)
    }
}
