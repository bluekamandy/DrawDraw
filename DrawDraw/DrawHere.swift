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
    
    var numPoints: Int!
    
    var colorCenter: Int!
    
    var points: [Vector]!
    var colors: [Color]!
    
    override func setup() {
//        size(800, 600)
//        scalePixels()
        fullScreen()
        
        //frameRate = 60
        
        backgroundColor = Color(0)
        
        numPoints = 500
        
        points = []
        colors = []
        
        for index in 0..<numPoints {
            points.append(DrawViewController.Vector(x: CGFloat(random(width)), y: CGFloat(random(height))))
            colors.append(Color(random(255), random(255), random(255)))
            print(points[index])
        }
        
        for x in 0..<width {
            for y in 0..<height {
                var deltaArray: [CGFloat] = []
                for p in points {
                    deltaArray.append(distanceSquared(p.x, p.y, CGFloat(x), CGFloat(y)))
                }
                
                var lowest: CGFloat = distanceSquared(0, 0, CGFloat(width), CGFloat(height))
                var lowestIndex: Int = 0
                for index in 0..<deltaArray.count {
                    if deltaArray[index] < lowest {
                        lowest = deltaArray[index]
                        lowestIndex = index
                    }
                }
                
                stroke = colors[lowestIndex]
                pixel(x, y)
            }
        }
        print("Done")
    }
    
    
    override func draw() {
    
    }
    
}




