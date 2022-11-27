//
//  ItemsViewController.swift
//  CS329E_FinalProject
//
//  Created by Emily Wang on 11/26/22.
//

import UIKit
import CoreData

class ItemsViewController: UIViewController {

    var nameArray: [String] = []
    var priceArray: [Decimal] = []
    var delegate: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "calcToDataSegue" {
            let calcVC = delegate as! addExistItems
            calcVC.addItems(existNameArray: nameArray, existPriceArray: priceArray)
        }
    }
    
}
