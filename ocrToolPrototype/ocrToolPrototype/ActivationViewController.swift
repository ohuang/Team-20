//
//  ActivationViewController.swift
//  ocrToolPrototype
//
//  Created by Cade May on 4/26/19.
//  Copyright © 2019 Cade May. All rights reserved.
//

import Cocoa

class ActivationViewController: NSViewController, NSWindowDelegate {

    @IBOutlet weak var ocrButtonOutlet: NSButton!
    
    @IBOutlet weak var screenshotImageViewOutlet: NSImageView!
    
    // "Activate OCR" button pressed
    @IBAction func activateOcrPressed(_ sender: NSButton) {
        
        // hide this button
        self.ocrButtonOutlet.isHidden = true
        self.ocrButtonOutlet.isEnabled = false
            
        // take screenshot
        
        let displayID = CGMainDisplayID()
        
        
        let cgScreenshot = CGDisplayCreateImage(displayID)
        
        let nsScreenshot = NSImage.init(cgImage: cgScreenshot!, size: NSSize.zero)
        
        screenshotImageViewOutlet.image = nsScreenshot
        
        screenshotImageViewOutlet.imageScaling = NSImageScaling.scaleProportionallyUpOrDown
        
        /*
        let gImage = CGWindowListCreateImage(
            CGRect.null,
            CGWindowListOption.optionIncludingWindow,
            CGWindowID(window.windowNumber),
            CGWindowImageOption.bestResolution)
        
        let image = NSImage(cgImage: gImage!, size: self.window.frame.size)
        */
        // display screenshot
        
            
    }
    
    func windowDidResize(_ notification: Notification) {
        //print(view.window?.frame.size)
        print("here")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        //view.window?.delegate = self
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    

    
}

