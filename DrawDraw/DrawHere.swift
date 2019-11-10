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
        size(500,500)
        
        xPos = width/2
        yPos = height/2
    }
    
    override func draw() {
        clearCanvas(Color(127))
        stroke = Color(random(255), random(255), random(255))
        largeRect(random(width), random(height), 25)
        xPos = xPos > width || xPos < 0 ? width / 2 : xPos + random(-1,1)
        yPos = yPos > height || yPos < 0 ? height / 2 : yPos + random(-1,1)
        
        
    }
    
    func largeRect(_ x: Int, _ y: Int, _ squareSize: Int){
        
        for yp in 0..<squareSize {
            for xp in 0..<squareSize {
                pixel(xp + x, yp + y)
            }
        }
    }
}




