//
//  ViewController.swift
//  us_tips
//
//  Created by phuong le on 2/22/16.
//  Copyright © 2016 phuong le. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipPercentageSegment: UISegmentedControl!
    

    @IBOutlet weak var resultView: UIView!
    
    var isShowResult = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
                
        tipPercentageSegment.selectedSegmentIndex = SettingManager.instance.tipPercentageIndex
        
        
        
        tipPercentageSegment.alpha = 0
        resultView.alpha = 0
        
        
        
        billField.becomeFirstResponder()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        let lastBillAmount = SettingManager.instance.getLastBillAmount()
        
        if(lastBillAmount.characters.count > 0) {
            billField.text = lastBillAmount
            calculateTip()
            showResultAnimation(true)
        }
        
        
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        SettingManager.instance.saveLastBillAmount(billField.text!)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        
        let length = billField.text?.characters.count
        
        if (length == 0) {
            showResultAnimation(false)
        } else if(length == 1) {
            showResultAnimation(true)
        }
        
        calculateTip()
    }
    
    @IBAction func onEndEditing(sender: AnyObject) {
        
    }
    
    func calculateTip(){
        let amountBill = NSString(string: billField.text!).doubleValue
        
        let tipPercentage = SettingManager.instance.getTipPercentageDefault()
        
        let tip = amountBill * tipPercentage
        let total = amountBill + tip
        
        //tipLabel.text = String(format: "$%.2f", tip)
        //totalLabel.text = String(format: "$%.2f", total)
        
        tipLabel.text = formatCurrency(tip)
        totalLabel.text = formatCurrency(total)
    }
    
    @IBAction func onTipPercentageChanged(sender: AnyObject) {
        
        SettingManager.instance.saveTipPercentageDefaultIndex(tipPercentageSegment.selectedSegmentIndex)
        
        calculateTip()
    }
    
    override func viewWillAppear(animated: Bool) {
        tipPercentageSegment.selectedSegmentIndex = SettingManager.instance.tipPercentageIndex
        calculateTip()
    }

    @IBAction func onEditingBegin(sender: AnyObject) {
        //print("begin editing")
    }
    
    @IBAction func onEditingEnd(sender: AnyObject) {
        //print("end editing")
    }
    
    func showResultAnimation(isShow:Bool = true) {
        
        if(isShowResult == isShow) {
            return
        }
        
        isShowResult = isShow
        let alpha:CGFloat = isShowResult ? 1 : 0
        
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            
            self.tipPercentageSegment.alpha = alpha
            self.resultView.alpha = alpha
            
        }, completion: nil)
    }
    
    func formatCurrency(number:Double)->String {
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.locale = NSLocale.currentLocale()
        
        return formatter.stringFromNumber(number)!
    }
}
