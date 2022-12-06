//
//  AddRecItemViewController.swift
//  CS329E_FinalProject
//
//  Created by Jennifer Lin on 11/29/22.
//

import UIKit
import AVFoundation

class AddRecItemViewController: UIViewController {

    @IBOutlet weak var itemLabel: UILabel!
    
    @IBOutlet weak var priceInput: UITextField!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var quantityInput: UITextField!
    
    var selectedItem: String?
    
    let systemSoundID: SystemSoundID = 1325
    
    var groceryItem:GroceryItem = GroceryItem()
    
    var previousVC: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        priceLabel.isHidden = true
        priceInput.isHidden = true
        
        itemLabel.text = selectedItem
    }
    
    @IBAction func saveItemButton(_ sender: Any) {
        var itemName = selectedItem
        var quantityItem = Int(quantityInput.text!)
        
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
        
        //add item to list

        else{
            if soundSetting {AudioServicesPlaySystemSound(systemSoundID)}
                let controller = UIAlertController(
                    title: "Add successful!",
                    message: "Item added to list",
                    preferredStyle: .alert)
                controller.addAction(UIAlertAction(
                    title: "OK",
                    style: .default
                ))
                present(controller, animated:true)
                
            groceryItem.newItem = itemName!
            groceryItem.quantity = quantityItem!
            
            let mainVC = previousVC as? AddItemToList
            mainVC!.addItem(addedItem: groceryItem)
            
            groceryItem = GroceryItem()
            
        }
        }

        
        
            }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


