//
//  SettingsViewController.swift
//  CS329E_FinalProject
//
//  Created by Jennifer Lin on 11/15/22.
//

import UIKit

var soundSetting:Bool = true
var notifSetting:Bool = true
var darkModeSetting:Bool = false

class SettingsViewController: UIViewController {

    @IBOutlet weak var notifSwitch: UISwitch!
    
    @IBOutlet weak var soundSwitch: UISwitch!
    
    @IBOutlet weak var darkModeSwitch: UISwitch!
    
    var soundSwitchState: Bool = true
    var notifSwitchState: Bool = true
    var darkModeSwitchState: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notifSwitch.isOn = notifSwitchState
        darkModeSwitch.isOn = darkModeSwitchState
        soundSwitch.isOn = soundSwitchState
        setColor()
        soundSwitch.isOn = UserDefaults.standard.bool(forKey: "soundSwitchState")
        notifSwitch.isOn = UserDefaults.standard.bool(forKey: "notifSwitchState")
        darkModeSwitch.isOn = UserDefaults.standard.bool(forKey: "darkModeSwitchState")
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated:Bool) {
        super.viewDidAppear(false)
        setColor()
    }
    
    func setColor() {
        if darkModeSetting {
            overrideUserInterfaceStyle = .dark
        }
        else {
            overrideUserInterfaceStyle = .light
        }
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
            notifSwitchState = true
            //notifSwitch.isOn = true
        }
        else {
            notifSetting = false
            notifSwitchState = false
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
            soundSwitchState = true
            //soundSwitch.isOn = true
        }
        else {
            soundSetting = false
            soundSwitchState = false
            //soundSwitch.isOn = false
        }
    }
    
    @IBAction func darkModeSwitchChanged(_ sender: Any) {
        UserDefaults.standard.set(darkModeSwitch.isOn, forKey: "darkModeSwitchState")
        if darkModeSwitch.isOn {
            darkModeSetting = true
            darkModeSwitchState = true
            overrideUserInterfaceStyle = .dark
        }
        else {
            darkModeSetting = false
            darkModeSwitchState = false
            overrideUserInterfaceStyle = .light
        }
    }
}
