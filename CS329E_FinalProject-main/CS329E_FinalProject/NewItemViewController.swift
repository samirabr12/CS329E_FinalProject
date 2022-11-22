//
//  NewItemViewController.swift
//  CS329E_FinalProject
//
//  Created by Emily on 11/21/22.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext

class NewItemViewController: UIViewController {
    @IBOutlet weak var itemNameText: UITextField!
    @IBOutlet weak var itemPriceText: UITextField!
    
    var missingNameAlert = UIAlertController(title: "Error: Missing Item Name", message: "Please input an item name.", preferredStyle: .alert)
    var missingPriceAlert = UIAlertController(title: "Error: Missing Item Price", message: "Please input the item price.", preferredStyle: .alert)
    var itemSavedAlert = UIAlertController(title: "Save Successful", message: "Item saved!", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        missingNameAlert.addAction(UIAlertAction(title: "OK", style: .default))
        missingPriceAlert.addAction(UIAlertAction(title: "OK", style: .default))
        itemSavedAlert.addAction(UIAlertAction(title: "OK", style: .default))
    }

    @IBAction func saveItem(_ sender: Any) {
        if itemNameText.text == nil {
            present(missingNameAlert, animated: true)
        }
        if itemPriceText.text == nil {
            present(missingPriceAlert, animated: true)
        }
        
        storeItem(name: itemNameText, price: itemPriceText)
        present(itemSavedAlert, animated: true)
    }
    
    //clear core data before pushing, besides way to delete item in list. not my issue? might be lol
    //double check that items are saved, display saved items
    func storeItem (name: UITextField, price: UITextField) {
        let item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: context)

        let str: NSString = itemPriceText.text! as NSString //search this up
        let doublePrice: Double = str.doubleValue
        
        item.setValue(name.text, forKey: "itemName")
        item.setValue(doublePrice, forKey: "itemPrice")
        saveContext()
    }
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
