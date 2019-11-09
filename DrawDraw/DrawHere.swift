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
        backgroundColor = PixelData(r: 0, g: 0, b: 0)
        x1 = random(width/4)
        y1 = random(height/4)
        x2 = random(width/4,width)
        y2 = random(height/4,height)
        
        for i in 0..<4 {
            speed.append(random(-5.0, 5.0))
            print(speed[i])
        }

    }
    
    override func draw() {
        
        line2(x1, y1, x2, y2)
        x1 = x1 + speed[0]
        y1 = y1 + speed[1]
        x2 = x2 + speed[2]
        y2 = y2 + speed[3]
        
        stroke.r = (stroke.r + UInt8(random(5))) % 250
        //print("Red: \(stroke.r)")
        stroke.g = (stroke.g + UInt8(random(5))) % 250
        //print("Green: \(stroke.g)")
        stroke.b = (stroke.b + UInt8(random(5))) % 250
        //print("Blue: \(stroke.b)")
    }
}




