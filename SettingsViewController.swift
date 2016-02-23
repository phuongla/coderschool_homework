//
//  SettingsViewController.swift
//  us_tips
//
//  Created by phuong le on 2/22/16.
//  Copyright © 2016 phuong le. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipPercentageSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tipPercentageSegment.selectedSegmentIndex = SettingManager.instance.tipPercentageIndex
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    @IBAction func onTipPercentageChanged(sender: AnyObject) {
        SettingManager.instance.saveTipPercentageDefaultIndex(tipPercentageSegment.selectedSegmentIndex)
    }
    

}
