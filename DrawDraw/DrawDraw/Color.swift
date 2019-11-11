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
    
    // MARK: UICOLOR CONVENIENCE INITIALIZER FOR INTEGERS
    
    /// This is an extension of the UIColor initializer to accept standard 8-bit integers as parameters.
    ///
    /// Adapted from source 1:
    ///
    /// https://medium.com/ios-os-x-development/ios-extend-uicolor-with-custom-colors-93366ae148e6
    ///
    /// and source 2:
    ///
    /// https://theswiftdev.com/2018/05/03/uicolor-best-practices-in-swift/
    /// ```
    /// let color = Color(red: 100, green: 100, blue: 100)
    /// ```
    /// - parameter red: red value. From 0 to 255.
    /// - parameter green: green value. From 0 to 255.
    /// - parameter blue: blue value. From 0 to 255.
    
    convenience init(red: UInt8, green: UInt8, blue: UInt8) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
    
    // MARK: UICOLOR CONVENIENCE INITIALIZER FOR INTEGERS WITH ALPHA
    
    /// This is an extension of the UIColor initializer to accept standard 8-bit integers as parameters.
    ///
    /// Adapted from source 1:
    ///
    /// https://medium.com/ios-os-x-development/ios-extend-uicolor-with-custom-colors-93366ae148e6
    ///
    /// and source 2:
    ///
    /// https://theswiftdev.com/2018/05/03/uicolor-best-practices-in-swift/
    /// ```
    /// let color = Color(red: 100, green: 100, blue: 100, alpha: 100)
    /// ```
    /// - parameter red: red value. From 0 to 255.
    /// - parameter green: green value. From 0 to 255.
    /// - parameter blue: blue value. From 0 to 255.
    /// - parameter alpha: alpha value. From 0 to 255.
    
    convenience init(red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        let newAlpha = CGFloat(alpha)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: newAlpha)
    }
    
    // MARK: UICOLOR CONVENIENCE INITIALIZER FOR AN INTEGER FOR GRAY VALUES
    
    /// This is an extension of the UIColor initializer to accept a standard 8-bit integer as a parameters.
    ///
    /// Adapted from source 1:
    ///
    /// https://medium.com/ios-os-x-development/ios-extend-uicolor-with-custom-colors-93366ae148e6
    ///
    /// and source 2:
    ///
    /// https://theswiftdev.com/2018/05/03/uicolor-best-practices-in-swift/
    /// ```
    /// let color = Color(red: 100, green: 100, blue: 100, alpha: 100)
    /// ```
    /// - parameter white: white value. From 0 to 255.
    
    convenience init(white: UInt8) {
        let newRed = CGFloat(white)/255
        let newGreen = CGFloat(white)/255
        let newBlue = CGFloat(white)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
    
}
