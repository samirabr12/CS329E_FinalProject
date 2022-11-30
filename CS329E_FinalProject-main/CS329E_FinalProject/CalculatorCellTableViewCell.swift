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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameField.delegate = self
        priceField.delegate = self
       }
    
    //formats keyboard input so only 2 decimal places
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        if textField == self.priceField {
            guard let inputText = textField.text, let rangeDecimal = Range(range, in: inputText) else {
                return true
            }

            let tempText = inputText.replacingCharacters(in: rangeDecimal, with: string)
            let numCheck = tempText.isEmpty || (Double(tempText) != nil)
            let deciCount = tempText.components(separatedBy: ".").count - 1

            let digitCount: Int
            if let dotIndex = tempText.firstIndex(of: ".") {
                digitCount = tempText.distance(from: dotIndex, to: tempText.endIndex) - 1
            }
            else {
                digitCount = 0
            }

            return (numCheck) && (deciCount <= 1) && (digitCount <= 2)
        }
        return true
    }
    
    // Called when 'return' key pressed
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Called when the user clicks on the view outside of the UITextField
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
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
