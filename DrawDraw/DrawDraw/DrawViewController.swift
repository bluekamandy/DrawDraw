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

class DrawViewController: UIViewController {
    
    // MARK: - OUTLETS
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var pan: UIPanGestureRecognizer!
    
    // MARK: - PROPERTIES
    public struct PixelData {
        var a:UInt8 = 255
        var r:UInt8
        var g:UInt8
        var b:UInt8
    }
    
    public struct Vector {
        var x: CGFloat
        var y: CGFloat
    }
    
    var width: CGFloat = 500
    var height: CGFloat = 500
    var maxWidth: CGFloat!
    var maxHeight: CGFloat!
    var screenRatio: CGFloat!
    var screenFrame: CGRect!
    var frameRate: Int = 120
    
    var canvas:[PixelData]!
    
    var backgroundColorR:UInt8 = 127
    var backgroundColorG:UInt8 = 127
    var backgroundColorB:UInt8 = 127
    
    var backgroundColor = PixelData(r: 127, g: 127, b: 127)
    var stroke: PixelData!
    
    var initialCenter: CGPoint!
    var touchX: CGFloat = 0.0
    var touchY: CGFloat = 0.0
    
    // MARK: - LAUNCH ORDER
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black
        imageView.layer.magnificationFilter = CALayerContentsFilter.nearest
        imageView.contentMode = .topLeft
        
        
    }
    
    override func viewDidLayoutSubviews() {
        
        // Setup Pixel Array
        canvas = [PixelData](repeatElement(PixelData.init(r: backgroundColor.r, g: backgroundColor.g, b: backgroundColor.b), count: Int(width*height)))
        imageView.image = imageFromARGB32Bitmap(pixels: canvas, width: Int(width), height: Int(height))
        screenFrame = self.view.frame
        stroke = PixelData(r: 0, g: 0, b: 0)
        
        maxWidth = screenFrame.width
        maxHeight = screenFrame.height
        print("maxWidth = \(maxWidth)")
        print("maxHeight = \(maxHeight)")
        screenRatio = maxHeight/maxWidth
        print("maxHeight/maxWidth = \(maxHeight/maxWidth)")
        
        
        setup()
        
        // Create Display Link
        createDisplayLink(fps: frameRate)
    }
    
    open func setup() {
        
    }
    
    open func draw() {
        
    }
    
    // MARK: - TOUCHES
    
    @IBAction func screenTapped(_ sender: Any) {
        viewDidLayoutSubviews()
        print("tap")
    }
    
    @IBAction func handlePan(_ recognizer: UIPanGestureRecognizer) {
        guard pan.view != nil else {return}
        
        if pan.state == .began || pan.state == .changed || pan.state == .ended {
            touchX = map(recognizer.location(in: view).x, 0, view.frame.width, 0, width)
            print("x is \(touchX)")
            touchY = map(recognizer.location(in: view).y,0,view.frame.height,height - width*screenRatio,height)
            print("y is \(touchY)")
        }
        
    }
    
    // MARK: - DISPLAY LINK
    // Creating Link to Display for Refreshing 60 fps
    
    func createDisplayLink(fps: Int) {
        let displaylink = CADisplayLink(target: self,
                                        selector: #selector(step))
        
        displaylink.preferredFramesPerSecond = fps
        
        displaylink.add(to: .current,
                        forMode: .default)
    }
    
    @objc func step(displaylink: CADisplayLink) {
        imageView.image = imageFromARGB32Bitmap(pixels: canvas, width: Int(width), height: Int(height))
        draw()
    }
    
    // MARK: - FRAMEWORK FUNCTIONS
    
    func size(_ width: CGFloat, _ height: CGFloat) {
        self.width = width
        self.height = height
        
        canvas = [PixelData](repeatElement(PixelData.init(r: backgroundColor.r, g: backgroundColor.g, b: backgroundColor.b), count: Int(width*height)))
    }
    
    func fullScreen() {
        self.width = maxWidth
        self.height = maxHeight
        
        canvas = [PixelData](repeatElement(PixelData.init(r: backgroundColor.r, g: backgroundColor.g, b: backgroundColor.b), count: Int(width*height)))
    }
    
    func scalePixels() {
        imageView.contentMode = .scaleAspectFit
    }
    
    func randomStatic(_ width: Int, _ height: Int) {
        
        var data:[PixelData] = []
        
        for row in 0..<height {
            for column in 0..<width {
                data.append(PixelData.init(
                    r: UInt8.random(in: 0...255),
                    g: UInt8.random(in: 0...255),
                    b: UInt8.random(in: 0...255)))
            }
        }
        
        canvas = data
    }
    
    func imageFromARGB32Bitmap(pixels: [PixelData], width: Int, height: Int) -> UIImage? {
        guard width > 0 && height > 0 else { return nil }
        guard pixels.count == width * height else { return nil }
        
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue)
        let bitsPerComponent = 8
        let bitsPerPixel = 32
        
        var data = pixels // Copy to mutable []
        guard let providerRef = CGDataProvider(data: NSData(bytes: &data,
                                                            length: data.count * MemoryLayout<PixelData>.size)
            )
            else { return nil }
        
        guard let cgim = CGImage(
            width: width,
            height: height,
            bitsPerComponent: bitsPerComponent,
            bitsPerPixel: bitsPerPixel,
            bytesPerRow: width * MemoryLayout<PixelData>.size,
            space: rgbColorSpace,
            bitmapInfo: bitmapInfo,
            provider: providerRef,
            decode: nil,
            shouldInterpolate: false,
            intent: .defaultIntent
            )
            else { return nil }
        
        return UIImage(cgImage: cgim)
    }
    
    
    func pixel(_ x: CGFloat, _ y: CGFloat, _ color: PixelData) {
        // Implementing a "wrap-around" toroidal 2d coordinate space
        //        var xt = abs(x.truncatingRemainder(dividingBy: width-1))
        //        var yt = abs(y.truncatingRemainder(dividingBy: height-1))\
        
        var xt: CGFloat!
        var yt: CGFloat!
        if x > 0 && y > 0 && x < width && y < height{
            xt = x.truncatingRemainder(dividingBy: width-1)
            yt = y.truncatingRemainder(dividingBy: height-1)
        } else {
            return
        }
        var pixelNumber = Int(xt + width * yt)
        canvas[pixelNumber] = PixelData(r: color.r, g: color.g, b: color.b)
    }
    
    // MARK: - UNDERSTANDING BRESERNHAM'S LINE ALGORITHM
    
    /**
     Simple Line Function
     
     **Citation**
     
     **Title:** Graphics & Visualization: Principles & Algorithms
     
     **Author:** T. Theoharis, G. Papaioannou, N. Platis, N. Patrikalakis
     
     **Date:** 2008
     
     **Code version:** N/A
     
     **Availability:** http://graphics.cs.aueb.gr/cgvizbook/index.html
     
     - parameters:
     - x1: Starting x position
     - y1: Starting y position
     - x2: Ending x position
     - y2: Ending y position
     */
    
    func line(_ x1: CGFloat, _ y1: CGFloat, _ x2:CGFloat, _ y2:CGFloat) {
        var slope: CGFloat
        var x,y: CGFloat
        slope = (y2-y1) / (x2-x1)
        
        x = x1
        y = y1
        if x2 > x1 {
            while x <= x2 {
                pixel(x,y, stroke)
                x = x + 1
                y = y1 + round(slope * (x-x1))
            }
        } else if x2 < x1 {
            while x >= x2 {
                pixel(x,y, stroke)
                x = x - 1
                y = y1 + round(slope * (x-x1))
            }
        }
    }
    
    func line2(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat) {
        var s,e: CGFloat
        var x,y: CGFloat
        e = 0
        s = (y2-y1) / (x2-x1)
        (x,y) = (x1,y1)
        while (x <= x2) {
            pixel(x,y, stroke)
            x = x + 1
            e = e + s
            if (e >= 1/2) {
                y = y + 1
                e = e - 1
            }
        }
    }
    
    //    func bresenhamLine(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat) {
    //        var x,y,e,dx,dy: CGFloat
    //        if dx == nil {
    //            dx = 0
    //        }
    //        if dy == nil {
    //            dy = 0
    //        }
    //        e = -(dx / 2)
    //        dx = (x2-x1)
    //        dy = (y2-y1)
    //        (x,y) = (x1, y1)
    //        while (x <= x2) {
    //            pixel(CGFloat(x),CGFloat(y),stroke);
    //            x = x + 1
    //            e = e + dy
    //            if (e >= 0) {
    //                y = y + 1
    //                e = e - dx
    //            }
    //        }
    //    }
    
    
}




