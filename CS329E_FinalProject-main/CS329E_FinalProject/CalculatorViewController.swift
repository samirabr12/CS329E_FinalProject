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
    func addItems(existNameArray: [String], existPriceArray: [Float])
}

class CalculatorViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, addExistItems {
    
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var calcTable: UITableView!
    
    var nameStorage: [String?] = []
    var priceStorage: [Float?] = []
    let cellIdentifier = "tableCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calcTable.delegate = self
        calcTable.dataSource = self
        total.text = "$0.00"
        nameStorage.append(nil)
        priceStorage.append(nil)
        
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
        if segue.identifier == "calcToDataSegue" {
            let itemVC = segue.destination as! DatabaseViewController
            itemVC.delegate = self
        }
    }
    
    //called when items are added from the database of existing items
    func addItems(existNameArray: [String], existPriceArray: [Float]) {
        nameStorage.append(contentsOf: existNameArray)
        priceStorage.append(contentsOf: existPriceArray)

        calcTable.beginUpdates()
        calcTable.insertRows(at: [IndexPath(row: priceStorage.count-1, section: 0)], with: .automatic)
        calcTable.endUpdates()
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
        else {
            cell.nameField.text = ""
        }
        if priceStorage[row] != nil {
            cell.priceField.text = "\(priceStorage[row]!)" // look this up!!
        }
        else{ // may need to check back here if having issues with "" and nil
            cell.priceField.text = ""
        }
        print("row is: \(row)")

        return cell
    }
    
    //deals with keyboard dismissal
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            nameStorage.remove(at: indexPath.row)
            priceStorage.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        else if editingStyle == .insert {
        }
    }

    func keyboardTap() {
        self.view.endEditing(true)
    }
    
    //saves any changes to the name of item in a cell
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
    
    //saves any changes to the price of item in a cell
    func priceEditInVC(price: String?, passedIndex: IndexPath) {
        let row = passedIndex.row
        let cell = calcTable.cellForRow(at: passedIndex) as! CalculatorCellTableViewCell
        var tempDecimal: Float!
        
        if price == nil {
            priceStorage[row] = nil
        }
        else {
            let formatter = NumberFormatter()
            formatter.generatesDecimalNumbers = true
            formatter.numberStyle = NumberFormatter.Style.decimal
            if let formattedNumber = formatter.number(from: cell.priceField.text!) as? Float {
                tempDecimal = formattedNumber
            }
            priceStorage[row] = tempDecimal
        }
    }
    
    //allows user to add rows as they please
    @IBAction func addRowButton(_ sender: Any) {
        nameStorage.append(nil)
        priceStorage.append(nil)
        
        calcTable.beginUpdates()
        calcTable.insertRows(at: [IndexPath(row: priceStorage.count-1, section: 0)], with: .automatic)
        calcTable.endUpdates()
    }
    
    @IBAction func calculateButton(_ sender: Any) {
        //double checks that all prices have been entered
        if priceStorage.contains(nil) {
            let calcAlert = UIAlertController(title: "Missing price(s)", message: "Please enter one or more price(s).", preferredStyle: .alert)
            calcAlert.addAction(UIAlertAction(title: "OK", style: .default))
            present(calcAlert, animated: true)
        }
        else {
            //calculate and display results
            var result: Float = 0
            for price in priceStorage {
                result = result + price!
            }
            
            let formatter = NumberFormatter()
            //formatter.locale = Locale.Region(identifier: "")
            formatter.numberStyle = .currency
            if let formattedResult = formatter.string(from: result as NSNumber) {
                total.text = "\(formattedResult)"
            }
        }
    }
    
    @IBAction func resetButton(_ sender: Any) {
        let resetAlert = UIAlertController(title: "Are you sure you want to reset the calculator?", message: "This will remove all entries.", preferredStyle: .alert)
        resetAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: {(alert: UIAlertAction!) in
            self.nameStorage = [nil]
            self.priceStorage = [nil]
            self.total.text = "$0.00"
            self.calcTable.reloadData()
        }))
        resetAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(resetAlert, animated: true)
    }
}
