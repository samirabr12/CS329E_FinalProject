//
//  ViewController.swift
//  WangEmily-HW7
//
//  Created by Emily Wang on 10/30/22.
//  Project: WangEmily-HW7
//  EID: ew6985
//  Course: CS329E

import UIKit
//import Foundation

protocol TimerCreator {
    func createTimer(newTimer: [String], timerFlag: Bool)
}

class Timer {
    var event: String
    var locations: String
    var timers: String
    
    init(timerInfo: [String]) {
        event = timerInfo[0]
        locations = timerInfo[1]
        timers = timerInfo[2]
    }
}

//public var timerList: [Timer] = []
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TimerCreator {
    @IBOutlet weak var tableView: UITableView!
    
    var delegateTime: addTimerViewController!
    var timerList: [Timer] = []
    let tableCellIdentifier = "cellIdentity"
    var countTimer: Timer!
    var rowIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //need super.viewWillAppear() ?
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        rowIndex = row
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellIdentifier, for: indexPath) as! CustomTableViewCell
        cell.eventLabel.text! = timerList[row].event
        cell.locationLabel.text! = timerList[row].locations
        cell.timerLabel.text! = timerList[row].timers
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //manually put segue in here? i think its already been done bc of link in storyboard
        let row = indexPath.row 
        tableView.deselectRow(at: indexPath, animated: true)
        countTimer = timerList[row]
        //print("table \(countTimer.event)")
        self.performSegue(withIdentifier:"countdownSegue", sender: self)
    }
    
    
    func createTimer(newTimer: [String], timerFlag: Bool) {
        if !timerFlag {
            let newTimer = Timer(timerInfo: newTimer)
            timerList.append(newTimer)
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addTimerSegue",
           let addVC = segue.destination as? addTimerViewController {
            addVC.delegate = self
        }
        
        if segue.identifier == "countdownSegue", let countVC = segue.destination as? CountdownViewController {
            countVC.delegate = self
            countVC.countdownTimer = countTimer
            //print("count \(countTimer.event)")
            countVC.index = rowIndex
        }
    }
}

