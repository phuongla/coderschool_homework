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
    
    let thresholdTime = 600
    let tipPercentageKeyName:String = "tipPercentage"
    let billAmountKeyName:String = "billAmount"
    let lastSavedTimeKeyName:String = "lastSavedTime"
    
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
    
    func getLastBillAmount() -> String {
        let defaults = NSUserDefaults.standardUserDefaults()
        let lastSavedTime = defaults.integerForKey(lastSavedTimeKeyName)
        let now = NSDate()
        
        
        var lastBillAmount = ""
        
        if(Int(now.timeIntervalSince1970) - lastSavedTime <= thresholdTime) {
            lastBillAmount = defaults.stringForKey(billAmountKeyName)!
        }
        
        return lastBillAmount
    }
    
    func saveLastBillAmount(lastBillAmount:String) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(lastBillAmount, forKey: billAmountKeyName)
        
        let date = NSDate()
        let timeSecond = Int(date.timeIntervalSince1970)
        
        defaults.setInteger(timeSecond, forKey: lastSavedTimeKeyName)
        
        defaults.synchronize()
    }
}