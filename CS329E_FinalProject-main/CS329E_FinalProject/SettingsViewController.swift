//
//  SettingsViewController.swift
//  CS329E_FinalProject
//
//  Created by Jennifer Lin on 11/15/22.
//

import UIKit

var soundSetting:Bool = true
var notifSetting:Bool = false

class SettingsViewController: UIViewController {

    @IBOutlet weak var notifSwitch: UISwitch!
    
    @IBOutlet weak var soundSwitch: UISwitch!
    
    var soundSwitchState: Bool!
    var notifSwitchState: Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        soundSwitch.isOn = UserDefaults.standard.bool(forKey: "soundSwitchState")
        notifSwitch.isOn = UserDefaults.standard.bool(forKey: "notifSwitchState")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func notifSwitchChanged(_ sender: Any) {
        UserDefaults.standard.set(notifSwitch.isOn, forKey: "notifSwitchState" )
        if notifSwitch.isOn {
            UNUserNotificationCenter.current().requestAuthorization(options:[.alert,.badge,.sound]) {
                granted, error in
                if granted {
                    DispatchQueue.main.async(execute: {
                        UIApplication.shared.registerForRemoteNotifications()})
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
            /*DispatchQueue.main.async(execute: {
                UIApplication.shared.registerForRemoteNotifications()})
            print(UIApplication.shared.isRegisteredForRemoteNotifications)*/
            notifSetting = true
            //notifSwitch.isOn = true
        }
        else {
            notifSetting = false
            //notifSwitch.isOn = false
        }
        /*else {
            UIApplication.shared.unregisterForRemoteNotifications()
            let controller = UIAlertController(
                title: "Notifications",
                message: "Notifications have been disabled",
                preferredStyle: .alert)
            controller.addAction(UIAlertAction(
                title: "OK",
                style: .default))
            present(controller, animated: true)
            
            print(UIApplication.shared.isRegisteredForRemoteNotifications)
        }*/
    }
    
    @IBAction func soundSettingChanged(_ sender: Any) {
        UserDefaults.standard.set(soundSwitch.isOn, forKey: "soundSwitchState" )
        if soundSwitch.isOn {
            soundSetting = true
            //soundSwitch.isOn = true
        }
        else {
            soundSetting = false
            //soundSwitch.isOn = false
        }
    }
    
}
