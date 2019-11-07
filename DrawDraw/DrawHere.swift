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
    
    var lineX: Int!
    var lineY: Int!
    
    override func setup() {
        fullScreen()
    }
    
    override func draw() {
        print("Refresh")
    }
}




