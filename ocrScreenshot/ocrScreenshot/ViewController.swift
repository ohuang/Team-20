//
//  ViewController.swift
//  ocrScreenshot
//
//  Created by Cade May on 4/28/19.
//  Copyright © 2019 Cade May. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    var screenshot = ScreenshotView()
    
    
    lazy var window: NSWindow = self.view.window!
    
    var mouseLocation: NSPoint {
        return NSEvent.mouseLocation()
    }
    var location: NSPoint {
        return window.mouseLocationOutsideOfEventStream
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("in VC1")
        
        //addsubve
        /*
        NSEvent.addLocalMonitorForEvents(matching: [.mouseMoved]) {
            print("mouseLocation:", String(format: "%.1f, %.1f", self.mouseLocation.x, self.mouseLocation.y))
            print("windowLocation:", String(format: "%.1f, %.1f", self.location.x, self.location.y))
            return $0
        }
        */
        
        
        NSEvent.addGlobalMonitorForEvents(matching: [.leftMouseDown]) { _ in
            let loc = NSEvent.mouseLocation()
            self.screenshot.lmDown(point: loc)
        }
        
        NSEvent.addGlobalMonitorForEvents(matching: [.leftMouseDragged]) { _ in
            let loc = NSEvent.mouseLocation()
            print("VC: dragging LM")
            self.screenshot.lmDragged(point: loc)
        }
        
        NSEvent.addGlobalMonitorForEvents(matching: [.leftMouseUp]) { _ in
            let loc = NSEvent.mouseLocation()
            let rect = self.screenshot.lmUp()
            print("VC: rect,",rect)
        }
        
        
        
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    /*
    override func mouseDown(with event: NSEvent) {
        screenshot.mDown(with: event)
        NSLog("mouse down!");
    }
    */
    
    /*
    override func mouseDragged(with event: NSEvent) {
        screenshot.mDragged(with: event)
    }
    */
    
    override func mouseUp(with event: NSEvent) {
        let rect = screenshot.mUp(with: event)
        print(rect)
    }

}

