//
//  SettingManager.swift
//  us_tips
//
//  Created by phuong le on 2/22/16.
//  Copyright © 2016 phuong le. All rights reserved.
//

import Foundation

class SettingManager {
    static let instance  = SettingManager()
    
    let tipPercentageKeyName:String = "tipPercentage"
    let tipPercentages = [0.18, 0.2, 0.22]
    var tipPercentageIndex:Int
    
    private init() {
        let defaults = NSUserDefaults.standardUserDefaults()
        tipPercentageIndex = defaults.integerForKey(tipPercentageKeyName)
        
    }
    
    func getTipPercentageDefault() -> Double{
        return tipPercentages[tipPercentageIndex]
    }
    
    func saveTipPercentageDefaultIndex(tipPercentageIndex:Int) {
        self.tipPercentageIndex = tipPercentageIndex
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(self.tipPercentageIndex, forKey: tipPercentageKeyName)
        
        defaults.synchronize()
       
    }
}