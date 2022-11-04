//
//  AddItemViewController.swift
//  CS329E_FinalProject
//
//  Created by Emily Wang on 11/3/22.
//

import UIKit

class AddItemViewController: UIViewController {
    //var for objects in new item view
    @IBOutlet weak var itemInput: UITextField!
    @IBOutlet weak var priceInput: UITextField!
    //var for actual views
    @IBOutlet weak var newItemView: UIView!
    @IBOutlet weak var existingItemView: UIView!
    //var for objects in existing item view
    //insert var here!
    
    @IBOutlet weak var itemSegmentedCtrl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func switchItem(_ sender: Any) {
        switch itemSegmentedCtrl.selectedSegmentIndex{
        case 0:
            newItemView.isHidden = true
            existingItemView.isHidden = false
        case 1:
            newItemView.isHidden = false
            existingItemView.isHidden = true
        default:
            break
        }
    }
    
    @IBAction func saveItemButton(_ sender: Any) {
        //add it into core data
        //also maybe send the item to the list view and display it
    }
}
