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
    
    var lineX1: CGFloat!
    var lineY1: CGFloat!
    var lineX2: CGFloat!
    var lineY2: CGFloat!
    
    var vector1: Vector!
    var vector2: Vector!
    
    var speed1: CGFloat!
    var speed2: CGFloat!
    
    override func setup() {
        fullScreen()
        
        speed1 = random(5.0)
        speed2 = random(5.0)
        
        vector1 = Vector(x: 1.0, y: 1.0)
        
        vector2 = Vector(x: 1.0, y: 1.0)
        
        lineX1 = random(width)
        lineY1 = random(height)
        
        lineX2 = random(width)
        lineY2 = random(height)
    }
    
    override func draw() {
        line(lineX1, lineY1, lineX2, lineY2)
        lineX1 = lineX1 + speed1
        lineY1 = lineY1 + speed1
        lineX2 = lineX2 + speed2
        lineX2 = lineY2 + speed2
    }
}




