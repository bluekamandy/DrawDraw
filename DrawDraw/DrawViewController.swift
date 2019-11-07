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
    
    // MARK: Outlets
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: Instance Variables and Structs
    public struct PixelData {
        var a:UInt8 = 255
        var r:UInt8
        var g:UInt8
        var b:UInt8
    }
    
    let width = 768
    let height = 1024
    
    var canvas:[PixelData]!
    
    let backgroundColor = UIColor.gray
    let strokeColor = UIColor.white
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = backgroundColor
        imageView.layer.magnificationFilter = CALayerContentsFilter.nearest
        
        // Setup Pixel Array
        canvas = [PixelData](repeatElement(PixelData.init(r: 0, g: 0, b: 0), count: width*height))
        imageView.image = imageFromARGB32Bitmap(pixels: canvas, width: width, height: height)
        
    }
    
    
    open func setup() {
        
    }
    
    open func draw() {
        
    }
    
    // MARK: DISPLAY LINK
    // Creating Link to Display for Refreshing 60 fps
    
    func createDisplayLink(fps: Int) {
        let displaylink = CADisplayLink(target: self,
                                        selector: #selector(step))
        
        displaylink.preferredFramesPerSecond = fps
        
        displaylink.add(to: .current,
                        forMode: .default)
    }
         
    @objc func step(displaylink: CADisplayLink) {
        draw()
    }
    
    // MARK: Actions
    
    @IBAction func redraw(_ sender: Any) {

    }
    
    // Framework Functions
    
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
    
    func line1(x1: Int, y1: Int, x2:Int, y2:Int) {
        var s: Float
        var x,y: Int
        s = Float(y2-y1) / Float(x2-x1)
        print("\(s) is the slope.")
        x = x1
        y = y1
        while x <= x2 {
            pixel(x,y)
            x = x+1
            y = y1 + Int(round(s * Float(x-x1)))
            print("(\(x),\(y))")
        }
        
    }
    
}




