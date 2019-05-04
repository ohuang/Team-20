//
//  AppDelegate.swift
//  ocrTool
//
//  Created by Cade May on 4/22/19.
//  Copyright © 2019 Cade May. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {

    var statusItem: NSStatusItem!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem = createStatusItem()
    }
    
    // called when the "Enter OCR Mode" button is pressed
    @objc func enterOcrMode(_ sender: Any?) {
        let screenshot = getScreenShot()
        let _ = CaptureWindow(image: screenshot) { image in
            let url = self.saveImage(image)
            if let text = self.runTess(url) {
                let pasteboard = NSPasteboard.general
                pasteboard.clearContents()
                pasteboard.declareTypes([.string], owner: nil)
                pasteboard.setString(text, forType: .string)
            }
        }
    }
    
    func runTess(_ url: URL) -> String? {
        let dirURL = self.appSupportDirectory()
        let outBase = dirURL.appendingPathComponent("out")
        let outURL = dirURL.appendingPathComponent("out.txt")
        
        let tess = Process()
        tess.launchPath = "/opt/local/bin/tesseract"
        tess.arguments = [url.path, outBase.path]
        do {
            try tess.run()
            tess.waitUntilExit()
        } catch { return nil }
        
        do {
            return try String.init(contentsOf: outURL)
        } catch { return nil }
    }
    
    func saveImage(_ image: NSImage) -> URL {
        var rect = CGRect(origin: .zero, size: image.size)
        let cgImage = image.cgImage(forProposedRect: &rect, context: nil, hints: nil)!
        let bitmap = NSBitmapImageRep(cgImage: cgImage)
        let data = bitmap.representation(using: .png, properties: [:])!
        
        let dirURL = self.appSupportDirectory()
        let fileURL = dirURL.appendingPathComponent("image.png")
        do {
            try data.write(to: fileURL)
            print(fileURL)
        } catch {}
        return fileURL
    }
    
    func appSupportDirectory() -> URL {
        let fileManager = FileManager.default
        let globalDirURL = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        let localDirURL = globalDirURL.appendingPathComponent("OCRTool")
        
        do {
            try fileManager.createDirectory(at: localDirURL,
                                            withIntermediateDirectories: false,
                                            attributes: nil)
        } catch {}
        
        return localDirURL
    }
    
    func getScreenShot() -> NSImage {
        // TODO: Look into CGDisplayCapture or whatever it's called
        
        let mainDisplayID = CGMainDisplayID()
        let screenshot = CGDisplayCreateImage(mainDisplayID)!
        let size = CGSize(width: screenshot.width / 2, height: screenshot.height / 2)
        return NSImage(cgImage: screenshot, size: size)
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
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit OCR Tool", action: #selector(NSApplication.terminate(_:)), keyEquivalent: ""))
        return menu
    }
}
