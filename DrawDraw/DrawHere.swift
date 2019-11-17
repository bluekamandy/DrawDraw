//
//  ViewController.swift
//  DrawDraw
//
//  Created by MASOOD KAMANDY on 11/1/19.
//  Copyright © 2019 Masood Kamandy. All rights reserved.
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
        fullScreen()
        //size(384,512)
        //scalePixels()
        
        frameRate = 120
        
        backgroundColor = Color(0)
        
        translateX = 0
        translateY = 0
        
        circleX = 10
        
        circleB = 0
        
    }
    
    override func draw() {
        
        stroke = Color(0, 0, circleB)
        
        filledRectangle(width*2/3, height/3, 200, 200)
        
        rotate(0.05)
        
        circleB = (circleB + 10) % 245
    }
    
    
    
    
    
}




