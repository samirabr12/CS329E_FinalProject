//
//  AddItemViewController.swift
//  CS329E_FinalProject
//
//  Created by Emily on 11/21/22.
//

import UIKit

class AddItemViewController: UIViewController {

    @IBOutlet weak var addItemSegmentedControl: UISegmentedControl!
//    @IBOutlet weak var newItemView: UIView!
//    @IBOutlet weak var existItemView: UIView!
//
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func switchItem(_ sender: Any) {
        switch addItemSegmentedControl.selectedSegmentIndex {
        case 0:
            performSegue(withIdentifier: "newItemSegue", sender: self)
//        case 1:
//            performSegue(withIdentifier: "existingItemSegue", sender: self)
        default:
            print("No item added")
        }
    }
    
//        switch itemSegCtrl.selectedSegmentIndex {
//        case 0:
//            UIView.animate(withDuration: 0.2, animations: { //want existing item view to be first since as item database grows, more likely to want existing items
//                self.existItemView.alpha = 1
//                self.newItemView.alpha = 0
//            })
//        case 1:
//            UIView.animate(withDuration: 0.2, animations: {
//                self.existItemView.alpha = 0
//                self.newItemView.alpha = 1
//
//            })
//        default:
//            break //what does this do exactly?
//        }
    }
    

