//
//  NewItemViewController.swift
//  CS329E_FinalProject
//
//  Created by Emily on 11/21/22.
//

import UIKit
import CoreData
import AVFoundation

class NewItemViewController: UIViewController {
    
    @IBOutlet weak var itemInput: UITextField!
    
    @IBOutlet weak var quantityInput: UITextField!
    
    @IBOutlet weak var priceInput: UITextField!
    
    var groceryItem:GroceryItem = GroceryItem()
    
    var previousVC:UIViewController?
    
    var itemName: String?
    var priceItem: Float? = 0.0
    var quantityItem: Int?
    let systemSoundID: SystemSoundID = 1325
    
    var delegate1:UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setColor()
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
    
    @IBAction func addItemToList(_ sender: Any) {
        itemName = itemInput.text!
        priceItem = Float(priceInput.text!)
        quantityItem = Int(quantityInput.text!)
        
        if itemName == "" {
            let controller = UIAlertController(
                title: "Missing item name",
                message: "Please enter the name of the item",
                preferredStyle: .alert)
            controller.addAction(UIAlertAction(
                title: "OK",
                style: .default
            ))
            present(controller, animated:true)
        }
        
        if priceItem == nil {
            let controller = UIAlertController(
                title: "Missing price",
                message: "Please enter the price of the item",
                preferredStyle: .alert)
            controller.addAction(UIAlertAction(
                title: "OK",
                style: .default
            ))
            present(controller, animated:true)
        }
        
        if quantityItem == nil {
            let controller = UIAlertController(
                title: "Missing quantity",
                message: "Please enter the quantity of the item (Whole numbers only!)",
                preferredStyle: .alert)
            controller.addAction(UIAlertAction(
                title: "OK",
                style: .default
            ))
            present(controller, animated:true)
        }
        
        if quantityItem != nil {
            if priceItem != nil {
                if soundSetting {
                    AudioServicesPlaySystemSound(systemSoundID)}
                
                let controller = UIAlertController(
                    title: "Add successful!",
                    message: "Item added to list",
                    preferredStyle: .alert)
                controller.addAction(UIAlertAction(
                    title: "OK",
                    style: .default
                ))
                present(controller, animated:true)
                
                if notifSetting {
                    let content = UNMutableNotificationContent()
                    content.title = "Added Item"
                    content.subtitle = "Notfication Alert"
                    content.body = "You have added an item to your list!"
                    content.sound = UNNotificationSound.default
                    
                    // create trigger
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 8, repeats: false)
                    
                    // combine it all into a request
                    let request = UNNotificationRequest(identifier: "myNotification", content: content, trigger: trigger)
                    
                    UNUserNotificationCenter.current().add(request)                     }
                
                groceryItem.newItem = itemName!
                groceryItem.price = priceItem
                groceryItem.quantity = quantityItem!
                let mainVC = delegate1 as? AddItemToList
                mainVC?.addItem(addedItem: groceryItem)
                groceryItem = GroceryItem()            }
        }}

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "quickAddSegue",
           let nextVC = segue.destination as? RecommendedItemViewController {
            nextVC.previousVC = previousVC
        }
    }
}
