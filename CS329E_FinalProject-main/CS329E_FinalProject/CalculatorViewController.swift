//
//  CalculatorViewController.swift
//  CS329E_FinalProject
//
//  Created by Emily Wang on 11/3/22.
//

import UIKit

protocol addExistItems {
    func nameEditInVC(name: String?, passedIndex: IndexPath)
    func priceEditInVC(price: String?, passedIndex: IndexPath)
    func keyboardTap()
    func addItems(existNameArray: [String], existPriceArray: [Decimal])
}

class CalculatorViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, addExistItems {
    
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var calcTable: UITableView!
    
    var nameStorage: [String?] = []
    var priceStorage: [Decimal?] = []
    let cellIdentifier = "tableCell"
    
    //https://stackoverflow.com/questions/49752220/get-data-from-custom-tableview-cell-text-field
    //google: text field inside custom table class swift
    
    override func viewDidLoad() { //optimize using threads?
        super.viewDidLoad()
        calcTable.delegate = self
        calcTable.dataSource = self
        //calcTable.keyboardDismissMode = .onDrag
        //calcTable.keyboardDismissMode = .interactive

        total.text = "0.00"
        
        nameStorage.append(nil)
        priceStorage.append(nil)
    }

//format decimal input and total output to two decimal places
//add alert to reset: are you sure you want to reset this calculator?
//add way to insert item when button is pressed
//when press calculate button, put up calculating alert and then display? depends on if we need animation
//or use threads and have it update in the background. (worry about number overflow? this is a problem for the very end lol)
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "calcToDataSegue" {
            let itemVC = segue.destination as! DatabaseViewController
            itemVC.delegate = self
        }
    }
    
    //called when items are added from the database of existing items.
    func addItems(existNameArray: [String], existPriceArray: [Decimal]) {
        nameStorage.append(contentsOf: existNameArray)
        priceStorage.append(contentsOf: existPriceArray)
        calcTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return priceStorage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CalculatorCellTableViewCell
        cell.delegate = self
        cell.cellIndexPath = indexPath
        if nameStorage[row] != nil{
            cell.nameField.text = nameStorage[row]
        }
        if priceStorage[row] != nil {
            cell.priceField.text = "\(priceStorage[row])" // look this up!!
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            nameStorage.remove(at: indexPath.row)
            priceStorage.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        else if editingStyle == .insert {
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }

    func keyboardTap() {
        //print("here2")
        self.view.endEditing(true)
    }
    
    func nameEditInVC(name: String?, passedIndex: IndexPath) {
        let row = passedIndex.row
        let cell = calcTable.cellForRow(at: passedIndex) as! CalculatorCellTableViewCell
        
        if name == nil {
            nameStorage[row] = nil
        }
        else {
            nameStorage[row] = cell.nameField.text
        }
    }
    
    func priceEditInVC(price: String?, passedIndex: IndexPath) {
        let row = passedIndex.row
        let cell = calcTable.cellForRow(at: passedIndex) as! CalculatorCellTableViewCell
        var tempDecimal: Decimal!
        
        if price == nil {
            priceStorage[row] = nil
        }
        else {
            let formatter = NumberFormatter()
            formatter.generatesDecimalNumbers = true
            formatter.numberStyle = NumberFormatter.Style.decimal
            if let formattedNumber = formatter.number(from: cell.priceField.text!) as? Decimal {
                tempDecimal = formattedNumber
            }
            
            priceStorage[row] = tempDecimal
        }
        //let priceString: NSString = cell.priceField.text! as NSString //search this up
    }
    
    @IBAction func calculateButton(_ sender: Any) {
        //double checks that all prices have been entered
        if priceStorage.contains(nil) {
            let calcAlert = UIAlertController(title: "Missing price(s)", message: "Please enter one or more price(s).", preferredStyle: .alert)
            calcAlert.addAction(UIAlertAction(title: "OK", style: .default))
            present(calcAlert, animated: true)
        }
        
        //calculate and display results
        var result: Decimal = 0
        for price in priceStorage {
            result = result + price!
        }
        total.text = "\(result)"
    }
    
    @IBAction func resetButton(_ sender: Any) {
        nameStorage = [nil]
        priceStorage = [nil]
        total.text = "0.00"
        calcTable.reloadData() //is this the best way to do it? prob not
    }
}
