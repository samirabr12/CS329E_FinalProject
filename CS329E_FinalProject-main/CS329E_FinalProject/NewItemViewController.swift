//
//  NewItemViewController.swift
//  CS329E_FinalProject
//
//  Created by Emily on 11/21/22.
//

import UIKit
import CoreData
import AVFoundation

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext

class NewItemViewController: UIViewController {
    @IBOutlet weak var itemNameText: UITextField!
    @IBOutlet weak var itemPriceText: UITextField!
    @IBOutlet weak var quantityPriceText: UILabel!
    
    let systemSoundID: SystemSoundID = 1325
    var missingNameAlert = UIAlertController(title: "Error: Missing Item Name", message: "Please input an item name.", preferredStyle: .alert)
    var missingPriceAlert = UIAlertController(title: "Error: Missing Item Price", message: "Please input the item price.", preferredStyle: .alert)
    var missingQuantityAlert = UIAlertController(title: "Error: Missing Item Quantity", message: "Please input the item quantity.", preferredStyle: .alert)
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
        
        if quantityPriceText.text == nil {
            present(missingQuantityAlert, animated: true)
        }
        
        AudioServicesPlaySystemSound(systemSoundID)
        storeItem(name: itemNameText, price: itemPriceText)
        present(itemSavedAlert, animated: true)
    }
    
    //clear core data before pushing, besides way to delete item in list. not my issue? might be lol
    //double check that items are saved, display saved items
    func storeItem (name: UITextField, price: UITextField) {
        let item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: context)
        var doublePrice: Decimal!
        
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = true
        formatter.numberStyle = NumberFormatter.Style.decimal
        //var doublePrice: NSNumber! = formatter.number(from: price.text!)
        
        if let formattedNumber = formatter.number(from: price.text!) as? Decimal  {
            doublePrice = formattedNumber
        }
        
        item.setValue(name.text, forKey: "itemName")
        item.setValue(doublePrice, forKey: "itemPrice")
        saveContext()
    }
    //remove before turning in. this is for testing
    func retrievePeople() -> [NSManagedObject] {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        var fetchedResults:[NSManagedObject]? = nil
        
//        let predicate = NSPredicate(format: "name CONTAINS[c] 'ie'")
//        request.predicate = predicate
        
        do {
            try fetchedResults = context.fetch(request) as? [NSManagedObject]
        } catch {
            // if an error occurs
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        return(fetchedResults)!
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
        
        //remove before turning in. this is for testing
        let fetchedResults = retrievePeople()
        
        for person in fetchedResults {
            if let itemName = person.value(forKey: "itemName") {
                if let itemPrice = person.value(forKey: "itemPrice") {
                    print("Retrieved: \(itemName), price \(itemPrice)")
                }
            }
        }
    }
    
}
