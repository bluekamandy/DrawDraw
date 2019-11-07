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
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}
