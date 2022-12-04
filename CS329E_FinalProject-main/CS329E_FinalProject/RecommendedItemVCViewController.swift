//
//  RecommendedItemVCViewController.swift
//  CS329E_FinalProject
//
//  Created by Jennifer Lin on 11/29/22.
//

import UIKit

class RecommendedItemViewController: UIViewController {

    var itemChosen: String?
    var previousVC: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recItemSegue",
           let nextVC = segue.destination as? AddRecItemViewController {
            let button = sender as! UIButton
            nextVC.selectedItem = button.titleLabel?.text
            nextVC.previousVC = previousVC
        }
    }
    
}
