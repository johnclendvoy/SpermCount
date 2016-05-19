//
//  ViewController.swift
//  Sperm Count
//
//  Created by John C. Lendvoy on 2016-05-19.
//  Copyright © 2016 John C. Lendvoy. All rights reserved.
//

import UIKit

var INCREASE = 1
var DECREASE = -1

class ViewController: UIViewController {
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet var countLabels: Array<UILabel>!
    @IBOutlet var percentLabels: Array<UILabel>!
    
    var count = [Int](count: 3, repeatedValue: 0)
    var percent = [Double](count: 3, repeatedValue: 0.0)

    var total: Int = 0
    var goal: Int = 10

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sort array of labels by tag (0 at top of screen)
        countLabels = countLabels.sort{ $0.tag < $1.tag }
        percentLabels = percentLabels.sort{ $0.tag < $1.tag }
        
        resetCounts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /**
    This method is called when the reset button is pressed.
    */
    @IBAction func reset(sender: AnyObject) {
        resetCounts()
    }
    
    /**
     Set all counts to zero. and update their labels.
    */
    func resetCounts() {
        total = 0
        displayTotal()
        hideResults()
        
        for i in 0...countLabels.count-1 {
            count[i] = 0
            displayCount(i)
            percent[i] = 0.0
            displayPercent(i)
        }
    }
    
    
    /**
     Called by a '+' button touch. Will increase the total and individual count for that type.
     */
    @IBAction func increase(sender: AnyObject) {
        if(total < goal){
            changeTotal(INCREASE)
            changeCount(sender.tag, change:INCREASE)
            updatePercents()
        }
    }
    
    /**
     Called by a '-' button touch. Will decrease the total and individual count for that type.
    */
    @IBAction func decrease(sender: AnyObject) {
        if(total > 0 && count[sender.tag] > 0){
            
            if(total == goal) {
                hideResults()
            }
            
            changeTotal(DECREASE)
            changeCount(sender.tag, change:DECREASE)
            updatePercents()
        }
    }
    
    /**
     Increase or decrease the total count by 1.
        - parameter change: should be -1 or 1 to represent decrease or increase
    */
    func changeTotal(change: Int) {
        total += change
        
        displayTotal()
        
        if(total == goal) {
            showResults()
        }
    }
    
    /**
     Increase or decrease the element of the count array by 1
        - parameter change: should be -1 or 1 to represent decrease or increase
    */
    func changeCount(tag: Int, change: Int) {
        count[tag] += change
        displayCount(tag)
        updatePercents()
    }
    
    /**
     Perform the math to calculate percent and display the percents for all types
    */
    func updatePercents() {
        for i in 0...percentLabels.count-1 {
            if(total == 0){
                percent[i] = 0.0
            }
            else {
                percent[i] = (Double(count[i]) / Double(total)) * 100.0
            }
            displayPercent(i)
        }
    }
    
    func displayPercent(i: Int){
        percentLabels![i].text = String(format: "%.1f%%", percent[i])
    }
    
    func displayTotal(){
        totalLabel.text = String(total) + " / " + String(goal)
    }
    
    func displayCount(i: Int) {
        countLabels[i].text = String(count[i])
    }
    
    func showResults() {
        view.backgroundColor = UIColor(red: 0.5, green: 1.0, blue: 0.5, alpha: 1.0)
    }
    
    func hideResults() {
        view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }

}

