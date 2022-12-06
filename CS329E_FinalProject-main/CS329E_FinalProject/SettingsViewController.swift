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
    var notifSwitchState: Bool = false
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
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
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
            notifSetting = true
            notifSwitchState = true
        }
        else {
            notifSetting = false
            notifSwitchState = false
        }
    }
    
    @IBAction func soundSettingChanged(_ sender: Any) {
        UserDefaults.standard.set(soundSwitch.isOn, forKey: "soundSwitchState" )
        if soundSwitch.isOn {
            soundSetting = true
            soundSwitchState = true
        }
        else {
            soundSetting = false
            soundSwitchState = false
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
