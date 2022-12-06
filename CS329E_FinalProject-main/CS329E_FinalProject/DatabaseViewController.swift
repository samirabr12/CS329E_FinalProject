//
//  DatabaseViewController.swift
//  CS329E_FinalProject
//
//  Created by Emily Wang on 11/29/22.
//

import UIKit
import CoreData

protocol addSelectedItems{
    func addSelected(index: IndexPath)
}

class DatabaseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, addSelectedItems {
    
    var nameArray: [String] = []
    var priceArray: [Decimal] = []
    var cellIdentifier = "dataCell"
    var nameSource: [String] = []
    var priceSource: [Decimal] = []
    //var unitSource: [String] = []
    var delegate: UIViewController!
    
    @IBOutlet weak var dataTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataTable.delegate = self
        dataTable.dataSource = self
        self.dataTable.allowsMultipleSelection = true
        self.dataTable.allowsMultipleSelectionDuringEditing = true
        
        let itemSource = self.retrieveItems()
        for item in itemSource {
            self.nameSource.append(item.value(forKey: "itemName") as! String)
            self.priceSource.append(item.value(forKey: "priceInput") as! Decimal)
        }
       /*
        let queue = DispatchQueue(label: "loadQueue", qos: .background)
        DispatchQueue.main.async {
            //start animation, bring view into screen?
            queue.sync {
                let itemSource = self.retrieveItems()
                for item in itemSource {
                    self.nameSource.append(item.value(forKey: "itemName") as! String)
                    self.priceSource.append(item.value(forKey: "itemPrice") as! Decimal)
                    //self.unitSource.append(item.value(forKey: "itemUnit") as! String)
                }
            }
            //stop animation, make view non-visible?
        }*/
    }
    
    func retrieveItems() -> [NSManagedObject] {
    
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "NewItem")
            var fetchedResults:[NSManagedObject]? = nil
    
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DatabaseTableViewCell
        cell.delegate = self
        cell.cellIndexPath = indexPath
        
        cell.cellName.text = nameSource[row]
        cell.cellPrice.text = "$ \(priceSource[row])"

        return cell
    }
    
    func addSelected(index: IndexPath) {
        //print(nameArray[0])
        nameArray.append(nameSource[index.row])
        priceArray.append(priceSource[index.row])
        print("hereAdd")
        //print(nameSource[index.row])
        //print(nameArray[0])
    }
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("hereCheck")
        if segue.identifier == "calcToDataSegue" {
            print("hereSegue")
            let calcVC = delegate as! addExistItems
            calcVC.addItems(existNameArray: nameArray, existPriceArray: priceArray)
        }
    }*/
    
    @IBAction func addItemsButton(_ sender: Any) {
        let calcVC = delegate as! addExistItems
        var tempNameArray = nameArray
        var tempPriceArray = priceArray
        nameArray = []
        priceArray = []
        calcVC.addItems(existNameArray: tempNameArray, existPriceArray: tempPriceArray)
    }
    
    func tempName () {
        print("hereCheck")
        let calcVC = delegate as! addExistItems
        var tempNameArray = nameArray
        var tempPriceArray = priceArray
        nameArray = []
        priceArray = []
        calcVC.addItems(existNameArray: tempNameArray, existPriceArray: tempPriceArray)
    }
}
