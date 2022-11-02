//
//  addTimerViewController.swift
//  WangEmily-HW7
//
//  Created by Emily Wang on 10/30/22.
//  Project: WangEmily-HW7
//  EID: ew6985
//  Course: CS329E

import UIKit

class addTimerViewController: UIViewController {
    @IBOutlet weak var eventInput: UITextField!
    @IBOutlet weak var locationInput: UITextField!
    @IBOutlet weak var timeInput: UITextField!
    
    var delegate: UIViewController!
    var aTimer: [String] = []
    var existingTimer = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        existingTimer = false
    }
    
    @IBAction func saveButton(_ sender: Any) {
        aTimer.append(eventInput.text!)
        aTimer.append(locationInput.text!)
        aTimer.append(timeInput.text!)
        let mainVC = delegate as! TimerCreator
        mainVC.createTimer(newTimer: aTimer, timerFlag: existingTimer)
        existingTimer = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addTimerSegue",
           let tableVC = segue.destination as? ViewController {
            tableVC.delegateTime = self
        }
    }
}
