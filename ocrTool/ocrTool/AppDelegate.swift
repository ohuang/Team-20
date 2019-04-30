//
//  AppDelegate.swift
//  ocrTool
//
//  Created by Cade May on 4/22/19.
//  Copyright © 2019 Cade May. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    
    //16.0 to be replaced with NSStatusItem.squareLength after updating xcode
    let statusItem = NSStatusBar.system().statusItem(withLength: 16.0)
    
    let model = MenuBarModel()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        
        if let button = statusItem.button {
            button.image = NSImage(named: "icon")
            //button.action = #selector(appSelected(_:)) //
        }
        
        // programmatically create menu
        constructMenu()
    }
    
    // called when the "Enter OCR Mode" button is pressed
    @objc func enterOcrMode(_ sender: Any?) {
        model.enableOCR()
    }

    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    // called when menu bar icon is selected
    @objc func appSelected(_ sender: Any?) {
        print("user has clicked the icon in the menu bar")
    }


    func constructMenu() {
        
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "Enter OCR Mode", action: #selector(AppDelegate.enterOcrMode(_:)), keyEquivalent: "P"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit OCR Tool", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        
        statusItem.menu = menu
    }

}

