//
//  CaptureWindow.swift
//  ocrTool
//
//  Created by Toby Bell on 5/3/19.
//  Copyright © 2019 Cade May. All rights reserved.
//

import Cocoa

class CaptureWindow: NSWindow {
    
    let image: NSImage
    let completionHandler: (NSImage) -> Void
    
    var dragged: Bool = false
    var dragStart: CGPoint = .zero
    var dragEnd: CGPoint = .zero
    
    let dragBox = NSView(frame: .zero)
    
    init?(image: NSImage, onComplete completionHandler: @escaping (NSImage) -> Void) {
        guard let screen = NSScreen.main else {
            return nil
        }
        self.image = image
        self.completionHandler = completionHandler
        super.init(contentRect: screen.visibleFrame,
                   styleMask: .borderless,
                   backing: .buffered,
                   defer: false)
        self.level = .screenSaver
        self.isReleasedWhenClosed = false
        
        let imageView = NSImageView(image: image)
        imageView.imageAlignment = .alignBottom
        imageView.imageScaling = .scaleNone
        imageView.frame = self.contentView!.bounds
        self.contentView!.addSubview(imageView)
        
        // Init drag box.
        dragBox.layer = CALayer()
        dragBox.layer!.borderColor = .white
        dragBox.layer!.borderWidth = 1
        dragBox.layer!.backgroundColor = CGColor(gray: 0, alpha: 0.13)
        
        self.contentView!.addSubview(dragBox)
        
        self.orderFront(nil)
    }
    
    override func mouseDown(with event: NSEvent) {
        self.dragStart = event.locationInWindow
    }
    
    override func mouseDragged(with event: NSEvent) {
        self.dragged = true
        self.dragEnd = event.locationInWindow
        self.dragBox.frame = boundingRect(self.dragStart, self.dragEnd)
    }
    
    override func mouseUp(with event: NSEvent) {
        if self.dragged {
            let result = self.createTargetImage()
            self.completionHandler(result)
            self.close()
        }
    }
    
    func createTargetImage() -> NSImage {
        NSGraphicsContext.saveGraphicsState()
        let rect = boundingRect(self.dragStart, self.dragEnd)
        let target = NSImage(size: rect.size)
        target.lockFocus()
        self.image.draw(in: NSRect(x: -rect.origin.x,
                                   y: -rect.origin.y,
                                   width: self.image.size.width,
                                   height: self.image.size.height))
        target.unlockFocus()
        NSGraphicsContext.restoreGraphicsState()
        return target
    }
}

func boundingRect(_ a: CGPoint, _ b: CGPoint) -> NSRect {
    let x0 = floor(min(a.x, b.x))
    let y0 = floor(min(a.y, b.y))
    let x1 = ceil(max(a.x, b.x))
    let y1 = ceil(max(a.y, b.y))
    return NSRect(x: x0, y: y0, width: x1 - x0, height: y1 - y0)
}
