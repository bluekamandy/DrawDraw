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
    public struct Color {
        let r, g, b, a :UInt8

        init(_ r: UInt8, _ g: UInt8, _ b: UInt8, _ a: UInt8) {
            self.r = r
            self.g = g
            self.b = b
            self.a = a
        }

        init(_ r: UInt8, _ g: UInt8, _ b: UInt8) {
            self.r = r
            self.g = g
            self.b = b
            self.a = 255
        }
        
        init(_ w: UInt8) {
            self.r = w
            self.g = w
            self.b = w
            self.a = 255
        }
     }
    
//    public struct Color {
//        var a:UInt8 = 255
//        var r:UInt8
//        var g:UInt8
//        var b:UInt8
//    }
    
    public struct Vector {
        var x: CGFloat
        var y: CGFloat
    }
    
    var width: Int = 500
    var height: Int = 500

    var maxWidth: Int!
    var maxHeight: Int!
    
    var screenRatio: CGFloat!
    var screenFrame: CGRect!
    var frameRate: Int = 60
    
    var canvas:[Color]!
    
    var backgroundColor = Color(127) {
        didSet {
            background(backgroundColor)
        }
    }

    var stroke: Color!
    
    var initialCenter: CGPoint!
    var touchX: Int = 0
    var touchY: Int = 0
    
    // MARK: - LAUNCH ORDER
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black
        imageView.layer.magnificationFilter = CALayerContentsFilter.nearest
        imageView.contentMode = .topLeft
        
        stroke = Color(255, 255, 255)
    }
    
    override func viewDidLayoutSubviews() {
        
        // Setup Pixel Array
        canvas = [Color](repeatElement(Color.init(backgroundColor.r, backgroundColor.g, backgroundColor.b), count: Int(width*height)))
        imageView.image = imageFromARGB32Bitmap(pixels: canvas, width: width, height: height)
        screenFrame = self.view.frame
        
        maxWidth = Int(screenFrame.width)
        maxHeight = Int(screenFrame.height)
        print("maxWidth = \(maxWidth)")
        print("maxHeight = \(maxHeight)")
        screenRatio = CGFloat(maxHeight)/CGFloat(maxWidth)
        print("maxHeight/maxWidth = \(CGFloat(maxHeight)/CGFloat(maxWidth))")
        
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
            touchX = Int(
                map(recognizer.location(in: view).x,
                    0,
                    view.frame.width,
                    0,
                    CGFloat(width)))
            print("x is \(touchX)")
            touchY = Int(
                map(recognizer.location(in: view).y,
                    0,
                    view.frame.height,CGFloat(height) - CGFloat(width)*screenRatio,
                    CGFloat(height)))
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
    
    func size(_ width: Int, _ height: Int) {
        self.width = width
        self.height = height
        
        canvas = [Color](repeatElement(Color.init(backgroundColor.r, backgroundColor.g, backgroundColor.b), count: Int(width*height)))
    }
    
    func fullScreen() {
        self.width = maxWidth
        self.height = maxHeight
        
        canvas = [Color](repeatElement(Color.init(backgroundColor.r, backgroundColor.g, backgroundColor.b), count: Int(width*height)))
    }
    
    func scalePixels() {
        imageView.contentMode = .scaleAspectFit
    }
    
    func background(_ color: Color) {
        canvas = Array(repeating: color, count: width*height)
    }
    
    func randomStatic(_ width: Int, _ height: Int) {
        
        var data:[Color] = []
        
        for row in 0..<height {
            for column in 0..<width {
                data.append(Color.init(
                    UInt8.random(in: 0...255),
                    UInt8.random(in: 0...255),
                    UInt8.random(in: 0...255)))
            }
        }
        
        canvas = data
    }
    
    func imageFromARGB32Bitmap(pixels: [Color], width: Int, height: Int) -> UIImage? {
        guard width > 0 && height > 0 else { return nil }
        guard pixels.count == width * height else { return nil }
        
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue)
        let bitsPerComponent = 8
        let bitsPerPixel = 32
        
        var data = pixels // Copy to mutable []
        guard let providerRef = CGDataProvider(data: NSData(bytes: &data,
                                                            length: data.count * MemoryLayout<Color>.size)
            )
            else { return nil }
        
        guard let cgim = CGImage(
            width: width,
            height: height,
            bitsPerComponent: bitsPerComponent,
            bitsPerPixel: bitsPerPixel,
            bytesPerRow: width * MemoryLayout<Color>.size,
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
    
    
    func pixel(_ x: Int, _ y: Int, _ color: Color) {
        // Implementing a "wrap-around" toroidal 2d coordinate space
        //        var xt = abs(x.truncatingRemainder(dividingBy: width-1))
        //        var yt = abs(y.truncatingRemainder(dividingBy: height-1))\
        
        var xt: Int!
        var yt: Int!
        if x > 0 && y > 0 && x < width && y < height{
            xt = x
            yt = y
        } else {
            return
        }
        var pixelNumber = xt + width * yt
        canvas[pixelNumber] = Color(color.r, color.g, color.b)
    }
    
     
    
    func line(_ x1: Int,_ y1: Int,_ x2: Int,_ y2: Int) {
        var dx = abs(x2-x1), sx:Int = x1<x2 ? 1 : -1
        var dy = -abs(y2-y1), sy:Int = y1<y2 ? 1 : -1
        var err = dx+dy,e2: Int
        
        var x = x1
        var y = y1
        
        while true {
            pixel(x, y, stroke)
            if (x == x2 && y == y2) { break }
            e2 = 2 * err
            if (e2 >= dy) { err += dy; x += sx }
            if (e2 <= dx) { err += dx; y += sy }
        }
    }
}




