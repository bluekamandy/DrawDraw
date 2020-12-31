//
//  ViewController.swift
//  DrawDraw
//
//  Created by MASOOD KAMANDY on 11/1/19.
//  Copyright © 2021 Masood Kamandy. All rights reserved.
//

import UIKit
import CoreGraphics
import QuartzCore

class DrawHere : DrawViewController {
    
    var circleX: Int!
    
    var translateX: Int!
    var translateY: Int!
    
    var circleR: UInt8!
    var circleG: UInt8!
    var circleB: UInt8!
    
    override func setup() {
        size(120, 90)
        scalePixels()
        
        frameRate = 120
        
        backgroundColor = Color(0)
        
        translateX = 0
        translateY = 0
        
        circleX = 10
        
        circleB = 0
        
    }
    
    override func draw() {
        
        stroke = Color(random(255), random(255), random(255))
        
        pixel(random(width) , random(height))
        
    }
    
    
    
    
    
}




