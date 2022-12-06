//
//  HomeVC.swift
//  CS329E_FinalProject
//
//  Created by Samira Ravilisetty on 11/29/22.
//

import UIKit
import CoreData
import FirebaseAuth

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext

var groceryList: [GroceryItem] = []
var coreDataList: [NSManagedObject] = []

protocol AddItemToList {
    func addItem(addedItem: GroceryItem)
}


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddItemToList {
    
    @IBOutlet weak var listTableView: UITableView!
    let textCellIdentifier = "listCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.delegate = self
        listTableView.dataSource = self
        
        //core data
        coreData()
        setColor()
        //self.view.backgroundColor = UIColor.black
        
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
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceryList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath) as! ItemTableViewCell
        let row = indexPath.row
        let item = groceryList[row]
        cell.itemLabelName?.text = "\(item.newItem)" + ": " + "\(item.quantity)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let toDelete = groceryList.remove(at: indexPath.row)
            listTableView.deleteRows(at: [indexPath], with: .fade)
            
            //delete from core data
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "NewItem")
            var fetchedResults:[NSManagedObject]
            do {
                try fetchedResults = context.fetch(request) as! [NSManagedObject]
    
                if fetchedResults.count > 0 {
                    for result:AnyObject in fetchedResults {
                        if result.objectID == toDelete.itemID{
                            context.delete(result as! NSManagedObject)
                        }
                    }
                }
                saveContext()
                
            } catch {
                // if an error occurs
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }        }
            
        }
    
    
    @IBAction func logout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true)
        } catch {
            print("Sign out error")
        }     }    
    //core data function
    func coreData(){
        //clearCoreData()
        let fetchedResult = retrieveList()

        for element in fetchedResult {
            if coreDataList.contains(element) == false {
                coreDataList.append(element)
                let newItem = GroceryItem()
                newItem.newItem = (element.value(forKey: "itemName") as? String)!
                newItem.quantity = (element.value(forKey: "quantityInput") as? Int)!
                newItem.price = element.value(forKey: "priceInput") as? Float
                newItem.itemID = element.objectID
                
                groceryList.append(newItem)
            }}
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addItemSegue",
            let nextVC = segue.destination as? NewItemViewController{
            nextVC.previousVC = self
            nextVC.delegate1 = self

        }
   }

    /*func saveList() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        
    }*/
    /*override func viewWillAppear(_ animated: Bool) {
        listTableView.reloadData()
    }*/
    @IBAction func addItemButton(_ sender: Any) {
    }
    
    func addItem(addedItem: GroceryItem) {
        groceryList.append(addedItem)
        self.listTableView.reloadData()
        
        let storedItem = NSEntityDescription.insertNewObject(forEntityName: "NewItem", into: context)
        
        storedItem.setValue(addedItem.newItem, forKey: "itemName")
        storedItem.setValue(addedItem.price, forKey: "priceInput")
        storedItem.setValue(addedItem.quantity, forKey: "quantityInput")
        coreDataList.append(storedItem)
        saveContext()
    }
    
    /*func newItem(_ item: GroceryItem) {
        storeList(newItem: item.newItem!, price: item.price!, quantity: item.quantity!)
        groceryList.append(item)
        listTableView.reloadData()
    }*/
    
    func retrieveList() -> [NSManagedObject] {
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "NewItem")
        var fetchedResult:[NSManagedObject]? = nil
        
        do {
            try fetchedResult = context.fetch(request) as? [NSManagedObject]
        } catch {
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        return(fetchedResult)!
    }
    
    func clearCoreData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "NewItem")
        var fetchedResult:[NSManagedObject]
        do {
            try fetchedResult = context.fetch(request) as! [NSManagedObject]
            if fetchedResult.count > 0 {
                for result:AnyObject in fetchedResult {
                    context.delete(result as! NSManagedObject)
                }
            }
            try context.save()
        } catch {
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
    }
    
    
    /*func storeList(newItem: String, price: Float, quantity: Int){
        let item = NSEntityDescription.insertNewObject(forEntityName: "ItemEntity", into: context)
        item.setValue(newItem, forKey: "newItem")
        item.setValue(price, forKey: "price")
        item.setValue(quantity, forKey: "quantity")
        saveContext()
    }*/
    
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
    
    /*func addItem(newItem: GroceryItem){
        groceryList.append(newItem)
    }*/

}
