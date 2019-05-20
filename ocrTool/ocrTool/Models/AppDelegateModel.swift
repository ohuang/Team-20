//
//  AppDelegateModel.swift
//  ocrTool
//
//  Created by Cade May on 5/8/19.
//  Copyright © 2019 Cade May. All rights reserved.
//

import Foundation
import Cocoa

class AppDelegateModel {
    
    let storage: UserDefaults
    
    init() {
        storage = UserDefaults.standard
    }
    
    func getScreenShot() -> NSImage {
        // TODO: Look into CGDisplayCapture or whatever it's called
        
        let mainDisplayID = CGMainDisplayID()
        let screenshot = CGDisplayCreateImage(mainDisplayID)!
        let size = CGSize(width: screenshot.width / 2, height: screenshot.height / 2)
        return NSImage(cgImage: screenshot, size: size)
    }
    
    func saveImage(_ image: NSImage) -> URL {
        var rect = CGRect(origin: .zero, size: image.size)
        let cgImage = image.cgImage(forProposedRect: &rect, context: nil, hints: nil)!
        let bitmap = NSBitmapImageRep(cgImage: cgImage)
        let data = bitmap.representation(using: .png, properties: [:])!
        
        let dirURL = appSupportDirectory()
        let fileURL = dirURL.appendingPathComponent("image.png")
        do {
            try data.write(to: fileURL)
        } catch {}
        return fileURL
    }
    
    func runTesseract(_ url: URL) -> String? {
        let dirURL = self.appSupportDirectory()
        let outBase = dirURL.appendingPathComponent("out")
        let outURL = dirURL.appendingPathComponent("out.txt")
        
        let tess = Process()
        tess.launchPath = "/usr/local/bin/tesseract"
        tess.arguments = [url.path, outBase.path]
        do {
            try tess.run()
            tess.waitUntilExit()
        } catch { return nil }
        
        do {
            return try String.init(contentsOf: outURL)
        } catch { return nil }
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
    
    func sayIt(_ text: String) {
        let tess = Process()
        tess.launchPath = "/usr/bin/say"
        tess.arguments = [text]
        do {
            try tess.run()
        } catch {}
    }
    
    
    
    func vocalizeSettingIsOn () -> Bool {
        
        var vocalizeSetting = 0
        
        if let vocalize = storage.object(forKey: "vocalizeSettingOn"), let v = vocalize as? Int {
            vocalizeSetting = v
        } else {
            vocalizeSetting = 0
        }
        
        //returns true if setting is 1, false if setting is 0
        return vocalizeSetting != 0
        
    }
}
