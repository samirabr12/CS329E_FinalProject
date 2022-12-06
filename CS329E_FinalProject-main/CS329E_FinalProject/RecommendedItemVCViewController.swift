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
        setColor()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recItemSegue",
           let nextVC = segue.destination as? AddRecItemViewController {
            let button = sender as! UIButton
            nextVC.selectedItem = button.titleLabel?.text
            nextVC.previousVC = previousVC
        }
    }
}
