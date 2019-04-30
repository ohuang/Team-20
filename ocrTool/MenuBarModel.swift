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
        let viewController = NSStoryboard(name: "Main", bundle: nil).instantiateController(withIdentifier: "imageView")
        
        // .instantiatViewControllerWithIdentifier() returns AnyObject! this must be downcast to utilize it
        
        presentViewController(viewController, animated: false, completion: nil)
        
        print("in model-main")
    }
    
    
    

}
