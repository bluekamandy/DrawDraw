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
    
    var colorIncrement: [UInt8] = []
    
    override func setup() {
        //size(300,400)
        fullScreen()
        scalePixels()
        backgroundColor = PixelData(r: 0, g: 0, b: 0)
        touchX = width/2
        touchY = height/2
        
        for i in 0..<3 {
            colorIncrement.append(random(1,8))
        }
        
    }
    
    override func draw() {
        
        line(width/2, height/2, touchX, touchY)
        
        if stroke.r < 255 - colorIncrement[0] {
            stroke.r += colorIncrement[0]
        } else {
            stroke.r = 0
        }
        
        if stroke.g < 255 - colorIncrement[1] {
            stroke.g += colorIncrement[1]
        } else {
            stroke.g = 0
        }
        
        if stroke.b < 255 - colorIncrement[2] {
            stroke.b += colorIncrement[2]
        } else {
            stroke.b = 0
        }
    }
}




