//
//  CountdownViewController.swift
//  WangEmily-HW7
//
//  Created by Emily Wang on 10/30/22.
//  Project: WangEmily-HW7
//  EID: ew6985
//  Course: CS329E

import UIKit
//import Foundation //i dont think this is necessary

class CountdownViewController: UIViewController {
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var counter: Int!
    var delegate: UIViewController!
    var countdownTimer: Timer!
    var index: Int!
    var onScreen = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventLabel.text = countdownTimer.event
        locationLabel.text = countdownTimer.locations
        timeLabel.text = countdownTimer.timers
        counter = Int(countdownTimer.timers)
        
        DispatchQueue.global().async {
            while (self.counter > 0 && self.onScreen) {
                sleep(1)
                self.counter -= 1
                DispatchQueue.main.sync { //look more about closures and using self. also, is it ok to use sync in this case?
                    self.timeLabel.text = String(self.counter)
                }
            }
        }
    }
 
    override func viewWillDisappear(_ animated: Bool) {
        onScreen = false
        countdownTimer.timers = String(counter)
    }
}
