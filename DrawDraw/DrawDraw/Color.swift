//
//  Color.swift
//  DrawDraw
//
//  Created by MASOOD KAMANDY on 11/3/19.
//  Copyright © 2019 Masood Kamandy. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit
    
public extension UIColor {
    
    // MARK: COLOR CONVENIENCE INITIALIZER FOR INTEGERS

    /// This is an extension of the UIColor initializer to accept standard 8-bit integers as parameters
    /// ```
    /// let randomNumber = random(50.0)
    /// ```
    /// - parameter upperBound: upper bound of random double values

    convenience init(red: UInt8, green: UInt8, blue: UInt8) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}
