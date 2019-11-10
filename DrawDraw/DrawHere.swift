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
    
    var xPos: Int!
    var yPos: Int!
    
    var randomIncrementX: Int!
    var randomIncrementY: Int!
    
    override func setup() {
        fullScreen()
        backgroundColor = Color(127)

        xPos = width/2
        yPos = height/2
        
    }
    
    override func draw() {
        backgroundColor = Color(0)
        line(xPos, yPos, 0, 0)
        line(0, height, xPos, yPos)
        line(xPos, yPos, width, height)
        line(width, 0, xPos, yPos)
        xPos = xPos > width ? 0 : xPos + random(-10,10)
        yPos = yPos > height ? 0 : yPos + random(-10,10)
        

    }
}




