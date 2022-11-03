//
//  NewItemViewController.swift
//  CS329E_FinalProject
//
//  Created by Emily Wang on 11/1/22.
//

import UIKit

class NewItemViewController: UIViewController {
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var itemPrice: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveItem(_ sender: Any) {
        //do i need to add something if there is no entered price?
        //add new item object to core data
    }
    
}
