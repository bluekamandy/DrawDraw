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
    
    var x1: CGFloat!
    var y1: CGFloat!
    var x2: CGFloat!
    var y2: CGFloat!
    
    var speed: [CGFloat] = []
    
    override func setup() {
        fullScreen()
        backgroundColor = UIColor.darkGray
        x1 = random(width)
        y1 = random(height)
        x2 = random(width)
        y2 = random(height)
        
        for _ in 0..<4 {
            speed.append(random(1.0))
        }

    }
    
    override func draw() {
        
        line2(x1, y1, x2, y2)
        x1 = x1 + speed[0]
        y1 = y1 + speed[1]
        x2 = x2 + speed[2]
        y2 = y2 + speed[3]
    }
}




