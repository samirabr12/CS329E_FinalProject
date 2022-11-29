//
//  CalculatorViewController.swift
//  CS329E_FinalProject
//
//  Created by Emily Wang on 11/3/22.
//

import UIKit

protocol addExistItems {
    func addItems(existNameArray: [String], existPriceArray: [Decimal])
}

class CalculatorViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, addExistItems, UITextFieldDelegate {
    
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var calcTable: UITableView!
    
    //These were causing errors so I commented them out - Jennifer
    //@IBOutlet weak var itemField: UITextField!
    //@IBOutlet weak var priceField: UITextField!
    
    var nameStorage: [String?] = []
    var priceStorage: [Decimal?] = []
    let cellIdentifier = "tableCell"
    
    //https://stackoverflow.com/questions/49752220/get-data-from-custom-tableview-cell-text-field
    //google: text field inside custom table class swift
    
    override func viewDidLoad() { //optimize using threads?
        super.viewDidLoad()
        calcTable.delegate = self
        calcTable.dataSource = self
        //itemField.delegate = self
        //priceField.delegate = self
        total.text = "0.00" // see if this works: /String(0.00)
        
        nameStorage.append(nil)
        priceStorage.append(nil)
    }
//add delete item button.
//add way to insert item when button is pressed
//when press calculate button, put up calculating alert and then display.
//or use threads and have it update in the background. (worry about number overflow? this is a problem for the very end lol)
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "calcToDataSegue" {
            let itemVC = segue.destination as! ItemsViewController
            itemVC.delegate = self
        }
    }
    
    // Called when 'return' key pressed

    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Called when the user clicks on the view outside of the UITextField

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
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
        //cell.label.text = nameStorage[row]
        //cell.nameField.text = nameStorage[row]
        if priceStorage[row] != nil {
            cell.priceField.text = "\(priceStorage[row])" // look this up!!
        }

        return cell
    }
    
    
    @IBAction func nameEdit(_ sender: Any) {
        let indexPath = IndexPath(row: 0, section: 0) //0?
        let row = indexPath.row
        let cell = calcTable.cellForRow(at: indexPath) as! CalculatorCellTableViewCell
        
        nameStorage[row] = cell.nameField.text
    }
    
    @IBAction func priceEdit(_ sender: Any) {
        let indexPath = IndexPath(row: 0, section: 0)
        let row = indexPath.row
        let cell = calcTable.cellForRow(at: indexPath) as! CalculatorCellTableViewCell
        var tempDouble: Decimal!
        
        //let priceString: NSString = cell.priceField.text! as NSString //search this up
        
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = true
        formatter.numberStyle = NumberFormatter.Style.decimal
        if let formattedNumber = formatter.number(from: cell.priceField.text!) as? Decimal  {
            tempDouble = formattedNumber
        }
        
        priceStorage[row] = tempDouble
    }
    
    //function that stores the name and price values when it is done being edited. how to do this? otherwise data will be lost if scroll
    //if less than 5 items are entered, then need a way not to show error
    //to do: threads? make sure cells are unselectable? calculating alert/message?
    
    
    @IBAction func calculateButton(_ sender: Any) {
        //double checks that all prices have been entered
        /*
        if priceStorage.contains(nil) {
            let calcAlert = UIAlertController(title: "Missing price(s)", message: "Please enter one or more price(s).", preferredStyle: .alert)
            calcAlert.addAction(UIAlertAction(title: "OK", style: .default))
            present(calcAlert, animated: true)
        }*/
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
