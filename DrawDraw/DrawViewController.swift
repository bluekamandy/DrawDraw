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
    
    // MARK: - PROPERTIES
    public struct PixelData {
        var a:UInt8 = 255
        var r:UInt8
        var g:UInt8
        var b:UInt8
    }
    
    var width = 500
    var height = 500
    var maxWidth: Int!
    var maxHeight: Int!
    var screenFrame: CGRect!
    var frameRate: Int = 60
    
    var canvas:[PixelData]!
    
    let backgroundColorR:UInt8 = 127
    let backgroundColorG:UInt8 = 127
    let backgroundColorB:UInt8 = 127
    
    let backgroundColor = UIColor(red: 127, green: 127, blue: 127)
    let strokeColor = UIColor.white
    
    // MARK: - LAUNCH ORDER
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black
        imageView.layer.magnificationFilter = CALayerContentsFilter.nearest
        imageView.contentMode = .topLeft
        
        // Setup Pixel Array
        canvas = [PixelData](repeatElement(PixelData.init(r: backgroundColorR, g: backgroundColorG, b: backgroundColorR), count: width*height))
        imageView.image = imageFromARGB32Bitmap(pixels: canvas, width: width, height: height)
        screenFrame = self.view.frame
    }
    
    override func viewDidLayoutSubviews() {
        maxWidth = Int(screenFrame.width)
        maxHeight = Int(screenFrame.height)
        setup()
        
        // Create Display Link
        createDisplayLink(fps: frameRate)
    }
    
    open func setup() {
        
    }
    
    open func draw() {
        
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
        imageView.image = imageFromARGB32Bitmap(pixels: canvas, width: width, height: height)
        draw()
    }
    
    // MARK: - FRAMEWORK FUNCTIONS
    
    func size(_ width: Int, _ height: Int) {
        self.width = width
        self.height = height
        
        canvas = [PixelData](repeatElement(PixelData.init(r: backgroundColorR, g: backgroundColorG, b: backgroundColorR), count: width*height))
    }
    
    func fullScreen() {
        self.width = maxWidth
        self.height = maxHeight
        
        canvas = [PixelData](repeatElement(PixelData.init(r: backgroundColorR, g: backgroundColorG, b: backgroundColorR), count: width*height))
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
    
    
    func pixel(_ x: Int, _ y: Int) {
        var pixelNumber = x + width * y
        canvas[pixelNumber] = PixelData(r: 255, g: 255, b: 255)
    }
    
    
    
    /**
     Simple Line Function
     
     Citation:
     
     Title: Graphics & Visualization: Principles & Algorithms
     Author: T. Theoharis, G. Papaioannou, N. Platis, N. Patrikalakis
     Date: 2008
     Code version: N/A
     Availability: http://graphics.cs.aueb.gr/cgvizbook/index.html

     - parameters:
        - x1: Starting x position
        - y1: Starting y position
        - x2: Ending x position
        - y2: Ending y position
     */
    
    func line(x1: Int, y1: Int, x2:Int, y2:Int) {
        var s: Float
        var x,y: Int
        s = Float(y2-y1) / Float(x2-x1)
        x = x1
        y = y1
        while x <= x2 {
            pixel(x,y)
            x = x+1
            y = y1 + Int(round(s * Float(x-x1)))
        }
        
    }
    
}




