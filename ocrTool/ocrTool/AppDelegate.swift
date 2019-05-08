//
//  AppDelegate.swift
//  ocrTool
//
//  Created by Cade May on 4/22/19.
//  Copyright © 2019 Cade May. All rights reserved.
//

// escape key ; transparent window instead; github issues; preferences panel


import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {

    var statusItem: NSStatusItem!
    //var storage = UserDefaults.standard
    let model = AppDelegateModel()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem = createStatusItem()
    }
    
    // called when the "Enter OCR Mode" button is pressed
    @objc func enterOcrMode(_ sender: Any?) {
        
        let screenshot = model.getScreenShot()
        
        let _ = CaptureWindow(image: screenshot) { image in
            
            let url = self.model.saveImage(image)
            
            if let text = self.model.runTesseract(url) {
                
                // copy captured text to clipboard
                let pasteboard = NSPasteboard.general
                pasteboard.clearContents()
                pasteboard.declareTypes([.string], owner: nil)
                pasteboard.setString(text, forType: .string)
                
                // vocalize captured text if vocalize preference is set to true
                if self.model.vocalizeSettingIsOn() {
                    self.model.sayIt(text)
                }

            }
        }
    }
    
    @objc func openPreferencesWindow(_ sender: Any?) {
        
        // TODO : under this current setup, clicking the "preferences" button multiple times
        // generates multiple preferences windows -- fix this!
        
        var myWindow: NSWindow? = nil
        let storyboard = NSStoryboard(name: "Main",bundle: nil)
        let controller = storyboard.instantiateController(withIdentifier: "PreferencesViewController")
        myWindow = NSWindow(contentViewController: controller as! NSViewController)
        myWindow?.makeKeyAndOrderFront(self)
        let vc = NSWindowController(window: myWindow)
        vc.showWindow(self)
        
    }
    
  
    func createStatusItem() -> NSStatusItem {
        let statusBar = NSStatusBar.system
        let item = statusBar.statusItem(withLength: NSStatusItem.squareLength)
        item.button!.image = NSImage(named: "icon")!
        item.menu = createStatusMenu()
        return item
    }

    func createStatusMenu() -> NSMenu {
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Capture Text", action: #selector(AppDelegate.enterOcrMode(_:)), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Preferences", action: #selector(AppDelegate.openPreferencesWindow(_:)), keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit OCR Tool", action: #selector(NSApplication.terminate(_:)), keyEquivalent: ""))
        return menu
    }
}
