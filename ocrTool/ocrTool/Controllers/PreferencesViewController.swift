//
//  PreferencesViewController.swift
//  ocrTool
//
//  Created by Cade May on 5/7/19.
//  Copyright © 2019 Cade May. All rights reserved.
//

import Cocoa

class PreferencesViewController: NSViewController {

    let model = PreferencesModel()
    
    @IBOutlet weak var vocalizeTextCheckBoxOutlet: NSButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do view setup here.
        model.configureVitalVariables()
        updateUI()
        
    }
    
    @IBAction func vocalizeCheckBoxAction(_ sender: NSButton) {
        model.storage.set(sender.state.rawValue, forKey: "vocalizeSettingOn")
    }
    
    func updateUI() {
        vocalizeTextCheckBoxOutlet.state = NSControl.StateValue(model.vocalizeCapturedText ?? 0)
    }
    
    
    
    override func viewWillDisappear() {
        print("preferences window closing; saving preferences just in case")
        saveVitals()
    }
    
    func saveVitals() {
        model.storage.set(vocalizeTextCheckBoxOutlet.state.rawValue, forKey: "vocalizeSettingOn")
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
}
