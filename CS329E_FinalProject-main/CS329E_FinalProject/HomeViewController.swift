//
//  HomeVC.swift
//  CS329E_FinalProject
//
//  Created by Samira Ravilisetty on 11/29/22.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate
//let context = appDelegate.persistentContainer.viewContext
let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

var groceryList: [NewItem] = []

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var listTableView: UITableView!
    let textCellIdentifier = "listCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.delegate = self
        listTableView.dataSource = self
        self.reloadGroceryList()
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceryList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath) as! ItemTableViewCell
        let row = indexPath.row
        cell.itemLabelName?.text = "\(groceryList[row].newItem)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groceryList.remove(at: indexPath.row)
            listTableView.deleteRows(at: [indexPath], with: .fade)
            saveList()
        } else if editingStyle == .insert {
        }
    }
    
    
    func reloadGroceryList(){
        let fetchedResult = retrieveList()
//        pizzaList.removeAll()
        for element in fetchedResult {
            let newItem = NewItem(newItem: element.value(forKey: "newItem") as! String,
                                price: element.value(forKey: "price") as! Float,
                                quantity: element.value(forKey: "quantity") as! Int)
            groceryList.append(newItem)
        }
    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        <#code#>
//    }
//
    func saveList() {
        clearCoreData()
        for item in groceryList {
            storeList(newItem: item.newItem, price: item.price, quantity: item.quantity)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        listTableView.reloadData()
    }
    
    func newItem(_ item: NewItem) {
        storeList(newItem: item.newItem, price: item.price, quantity: item.quantity)
        groceryList.append(item)
        listTableView.reloadData()
    }
    
    func retrieveList() -> [NSManagedObject] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ItemEntity")
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
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ItemEntity")
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
    
    
    func storeList(newItem: String, price: Float, quantity: Int){
        let item = NSEntityDescription.insertNewObject(forEntityName: "ItemEntity", into: context)
        item.setValue(newItem, forKey: "newItem")
        item.setValue(price, forKey: "price")
        item.setValue(quantity, forKey: "quantity")
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
    
    func addItem(newItem: NewItem){
        groceryList.append(newItem)
    }

}
