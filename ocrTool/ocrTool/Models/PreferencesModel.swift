//
//  PreferencesModel.swift
//  ocrTool
//
//  Created by Cade May on 5/7/19.
//  Copyright © 2019 Cade May. All rights reserved.
//

import Foundation

class PreferencesModel {
    
    let storage: UserDefaults
    
    var vocalizeCapturedText: Int?
    
    init() {
        storage = UserDefaults.standard
        
        configureVitalVariables()
    }
    
    func configureVitalVariables() {
        vocalizeCapturedText = getVocalizeSetting()
    }
    
    func getVocalizeSetting() -> Int {
        
        var toReturn = 0
        
        if let vocalize = storage.object(forKey: "vocalizeSettingOn"), let v = vocalize as? Int {
            toReturn = v
        } else {
            toReturn = 0
        }
        
        return toReturn
    }
    


}
