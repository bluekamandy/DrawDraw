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
    
    var v: CGFloat! // Raw volume from mic
    var easev: CGFloat = 0.0 // For easing. Needs to start out at 0.0
    var easing: CGFloat = 0.1 // The closer to 0 the smoother your animation. Closer to 1 the faster/harsher s the animation.
    
    override func setup() {
        fullScreen()
        
        backgroundColor = Color(0,0,255)
        
        xPos = width/2
        yPos = height/2
    }
    
    override func draw() {
        MicInput.shared.updateMeter()
        
        v = map(MicInput.shared.myVolume, 25, 75, 0, 200)
        easev += (v - easev) * easing // Easing Algorithm
        
        v = constrain(v, 0.0, 200.0)
        print(v)
        var randomWhite:UInt8 = random(255)
        stroke = Color(randomWhite)
        largeRect(xPos, yPos, Int(round(v)))
        
        if screenIsTouched {
            xPos = lerp(xPos, touchX, 0.01)
            yPos = lerp(yPos, touchY, 0.01)
        }
        
        xPos = xPos > width || xPos < 0 ? width / 2 : xPos + random(-5,5)
        yPos = yPos > height || yPos < 0 ? height / 2 : yPos + random(-5,5)
        
        
    }
    
    func largeRect(_ x: Int, _ y: Int, _ squareSize: Int){
        
        for yp in 0..<squareSize {
            for xp in 0..<squareSize {
                pixel(xp + x, yp + y)
            }
        }
    }
}




