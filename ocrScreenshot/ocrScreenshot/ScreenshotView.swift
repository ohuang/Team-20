
//
//  ScreenshotView.swift
//  ocrScreenshot
//
//  Created by Cade May on 4/28/19.
//  Copyright © 2019 Cade May. All rights reserved.
//

import Cocoa

//
//  ViewController.swift
//  ocrScreenshot
//
//  Created by Cade May on 4/28/19.
//  Copyright © 2019 Cade May. All rights reserved.
//

import Cocoa

class ScreenshotView: NSView {
    
    var firstMouseDownPoint: NSPoint = NSZeroPoint
    let myLayer = CAShapeLayer()
    let borderSize: CGFloat = 2.0
    
    //var rect: NSRect = NSRect(x: 0, y: 0, width: 0, height: 1)
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        self.layer?.backgroundColor = NSColor.lightGray.cgColor
        drawHole()
        Swift.print("draw")
        
    }
    
    
    func drawHole() {
        Swift.print("drawHole()")
        let path = CGMutablePath()
        // Make hole in view's overlay
        //path.addRect((self.superview?.bounds)!)
        path.addRect(NSRect(x: self.frame.origin.x + borderSize,
                            y: self.frame.origin.y + borderSize,
                            width: self.frame.size.width - (borderSize * 2),
                            height: self.frame.size.height - (borderSize * 2)))
        
        myLayer.path = path
        myLayer.fillRule = kCAFillRuleEvenOdd
        self.superview?.layer?.mask = myLayer
        self.layer?.borderColor = NSColor.lightGray.cgColor
        self.layer?.borderWidth = borderSize
        Swift.print("draw")
    }
    
    //Decrapted for now
    func getHole() -> CGImage {
        Swift.print("getHole()")
        
        var rect = self.convert((self.layer?.frame)!, to: self.window?.contentView)

        //  print("rect \(rect)")
        
        let displayID = CGMainDisplayID()
        return  CGDisplayCreateImage(displayID, rect: rect)!
    }
    
    func setWidth(width: CGFloat) {
        Swift.print("setWidth()")
        var f = self.frame;
        f.size.width = width;
        self.frame = f;
    }
    
    func setHeight(height: CGFloat) {
        Swift.print("setHeight()")
        var f = self.frame;
        f.size.height = height;
        self.frame = f;
        
    }
    
    
    func lmDown(point: NSPoint) {
        firstMouseDownPoint = point
        
        /*
        let mainStoryBoard = NSStoryboard(name: "Main", bundle: nil)
        let windowController = mainStoryBoard.instantiateController(withIdentifier: "Preferences") as! NSWindowController
        let w = windowController.window
        
        self.window = w
        */
        
        Swift.print("in lmDown()")
    }
    
    func lmDragged(point: NSPoint) {
        
        Swift.print("mouseDragged()")
        
        //let newPoint = (self.window?.contentView?.convert(point, to: self))!
        
        let newPoint = (convert(point, to: self))

        let offset = NSPoint(x: newPoint.x - firstMouseDownPoint.x, y: newPoint.y - firstMouseDownPoint.y)
        let origin = self.frame.origin
        let size = self.frame.size
        self.frame = NSRect(x: origin.x + offset.x, y: origin.y + offset.y, width: size.width, height: size.height)
        
        Swift.print("frame in dragged",  self.frame)
        //self.rect = NSRect(x: origin.x + offset.x, y: origin.y + offset.y, width: size.width, height: size.height)
        drawHole()
    }
    
    func lmUp() -> CGRect {
        let displayID = CGMainDisplayID()
        
        //var rect = self.convert((self.layer?.frame)!, to: self.window?.contentView)
        
        return NSRect(x: 0, y: 0, width: 0, height: 1)
        //return rect
    }
    
    
    /*
    func mDown(with event: NSEvent) {
        Swift.print("mouseDown()")
        firstMouseDownPoint = (self.window?.contentView?.convert(event.locationInWindow, to: self))!
        Swift.print("Mouse on: \(event.locationInWindow)")
        Swift.print("Mouse click on : \(firstMouseDownPoint)")
    }
    
    
    func mDragged(with event: NSEvent) {
        Swift.print("mouseDragged()")
        let newPoint = (self.window?.contentView?.convert(event.locationInWindow, to: self))!
        let offset = NSPoint(x: newPoint.x - firstMouseDownPoint.x, y: newPoint.y - firstMouseDownPoint.y)
        let origin = self.frame.origin
        let size = self.frame.size
        self.frame = NSRect(x: origin.x + offset.x, y: origin.y + offset.y, width: size.width, height: size.height)
        drawHole()
    }
    */
    
    func mUp(with event: NSEvent) -> CGRect {
        let displayID = CGMainDisplayID()
        
        var rect = self.convert((self.layer?.frame)!, to: self.window?.contentView)
        
        return rect
    }
    
    
    /*
    
    
    override func mouseDown(with event: NSEvent) {
        Swift.print("mouseDown()")
        firstMouseDownPoint = (self.window?.contentView?.convert(event.locationInWindow, to: self))!
        Swift.print("Mouse on: \(event.locationInWindow)")
        Swift.print("Mouse click on : \(firstMouseDownPoint)")
    }
    

    override func mouseDragged(with event: NSEvent) {
        
        Swift.print("mouseDragged()")
        let newPoint = (self.window?.contentView?.convert(event.locationInWindow, to: self))!
        let offset = NSPoint(x: newPoint.x - firstMouseDownPoint.x, y: newPoint.y - firstMouseDownPoint.y)
        let origin = self.frame.origin
        let size = self.frame.size
        self.frame = NSRect(x: origin.x + offset.x, y: origin.y + offset.y, width: size.width, height: size.height)
        drawHole()
    }
    
    override func mouseUp(with event: NSEvent) {
        
        let displayID = CGMainDisplayID()
    
        var rect = self.convert((self.layer?.frame)!, to: self.window?.contentView)
        
        let cgScreenshot = CGDisplayCreateImage(displayID, rect: rect)
        
        
    }
    */
}
