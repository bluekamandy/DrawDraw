//
//  Shapes.swift
//  DrawDraw
//
//  Created by Masood Kamandy on 12/30/20.
//  Copyright © 2021 Masood Kamandy. All rights reserved.
//

import Foundation

extension DrawViewController {
    
    // MARK: - FRAMEWORK FUNCTIONS - SHAPE PRIMITIVES
    
    func pixel(_ x: Int, _ y: Int) {
        var xt: Int!
        var yt: Int!
        if x > 0 && y > 0 && x < width && y < height{
            xt = x
            yt = y
        } else {
            return
        }
        var pixelNumber = xt + width * yt
        canvas[pixelNumber] = stroke
    }
    
    // Adapted from:  https://web.archive.org/web/20120314012420/http://free.pages.at/easyfilter/bresenham.html
    
    func line(_ x1: Int,_ y1: Int,_ x2: Int,_ y2: Int) {
        var dx = abs(x2-x1), sx:Int = x1<x2 ? 1 : -1
        var dy = -abs(y2-y1), sy:Int = y1<y2 ? 1 : -1
        var err = dx+dy,e2: Int
        
        var x = x1
        var y = y1
        
        while true {
            pixel(x, y)
            if (x == x2 && y == y2) { break }
            e2 = 2 * err
            if (e2 >= dy) { err += dy; x += sx }
            if (e2 <= dx) { err += dx; y += sy }
        }
    }
    
    func circle(_ xm: Int, _ ym: Int, _ r: Int) {
        var x = -r, y = 0, err = 2-2*r
        var r_ = r
        
        repeat {
            pixel(xm-x, ym+y)
            pixel(xm-y, ym-x)
            pixel(xm+x, ym-y)
            pixel(xm+y, ym+x)
            r_ = err
            if r_ > x {
                x += 1
                err += x*2+1
            }
            if r_ <= y {
                y += 1
                err += y*2+1
            }
        } while x < 0
    }
    
    func filledRectangle(_ x: Int, _ y: Int, _ w: Int, _ h: Int){
        
        for yp in 0..<h {
            for xp in 0..<w {
                pixel(xp + x, yp + y)
            }
        }
    }
}
