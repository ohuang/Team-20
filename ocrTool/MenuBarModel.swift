//
//  MenuBarModel.swift
//  ocrTool
//
//  Created by Cade May on 4/22/19.
//  Copyright © 2019 Cade May. All rights reserved.
//

import Foundation
import Cocoa

class MenuBarModel: NSObject {
    
    func enableOCR() {
        
        // take over the screen/cursor, then enable and execute OCR functionality
        
        NSCursor.crosshair().set()
        
        print("in model-main")
    }

}
