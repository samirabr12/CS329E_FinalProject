//
//  CalculatorCellTableViewCell.swift
//  CS329E_FinalProject
//
//  Created by Emily Wang on 11/3/22.
//

import UIKit

class CalculatorCellTableViewCell: UITableViewCell, UITextFieldDelegate {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    var delegate: UIViewController!
    var cellIndexPath: IndexPath!
    var xyz: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameField.delegate = self
        priceField.delegate = self
        //print(delegate)
       }
    
    // Called when 'return' key pressed
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Called when the user clicks on the view outside of the UITextField
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("HEREHEREHERE")
        let calcVC = delegate as! addExistItems
        calcVC.keyboardTap()
    }
    
    @IBAction func nameEdit(_ sender: Any) {
        let calcVC = delegate as! addExistItems
        calcVC.nameEditInVC(name: nameField.text ?? nil, passedIndex: cellIndexPath)
    }
    
    @IBAction func priceEdit(_ sender: Any) {
        let calcVC = delegate as! addExistItems
        calcVC.priceEditInVC(price: priceField.text ?? nil, passedIndex: cellIndexPath)
    }
}
