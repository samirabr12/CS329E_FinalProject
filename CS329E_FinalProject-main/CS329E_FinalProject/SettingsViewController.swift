//
//  SettingsViewController.swift
//  CS329E_FinalProject
//
//  Created by Jennifer Lin on 11/15/22.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var notifSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func notifSwitchChanged(_ sender: Any) {
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
            DispatchQueue.main.async(execute: {
                UIApplication.shared.registerForRemoteNotifications()})
            print(UIApplication.shared.isRegisteredForRemoteNotifications)
        }
        else {
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
        }
    }
}
