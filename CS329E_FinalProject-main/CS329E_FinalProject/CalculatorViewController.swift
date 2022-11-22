//
//  CalculatorViewController.swift
//  CS329E_FinalProject
//
//  Created by Emily Wang on 11/3/22.
//

import UIKit

class CalculatorViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var nameStorage: [String?] = []
    var priceStorage: [Decimal?] = []
    let cellIdentifier = "tableCell"
    
    //https://stackoverflow.com/questions/28394933/how-do-i-check-when-a-uitextfield-changes
    //https://supereasyapps.com/blog/2015/7/24/how-to-get-uitextfield-text-changed-events-for-your-validation-logic-swift-tips-1

    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var calcTable: UITableView!
    
    override func viewDidLoad() { //optimize using threads? how?
        super.viewDidLoad()
        total.text = "0.00" // see if this works: /String(0.00)
    }
//add delete item button.
//how to have things stored in lists without button? use threads?
//potential way to deal with text fields: save the array when dequeue?
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return priceStorage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CalculatorCellTableViewCell
        cell.nameField.text = nameStorage[row]
        cell.priceField.text = "/(priceStorage[row])"
        
        return cell
    }
   /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
    }
    */
    
    //double checks that all prices have been entered
    @IBAction func calculateButton(_ sender: Any) {
        for price in priceStorage {
             //var row = IndexPath.row
            
        }
        
        if priceStorage.contains(nil) {
            let calcAlert = UIAlertController(title: "Missing price(s)", message: "Please enter one or more price(s).", preferredStyle: .alert)
            calcAlert.addAction(UIAlertAction(title: "OK", style: .default))
            present(calcAlert, animated: true)
        }
        //calculate and display results
        var result:Decimal = 0
        for price in priceStorage {
            result = result + price!
        }
        total.text = "\(result)"
    }
    
    @IBAction func resetButton(_ sender: Any) {
        nameStorage = []
        priceStorage = []
        total.text = "0.00"
        calcTable.reloadData() //is this the best way to do it? prob not
    }
    
    
    //if it doesn't persist after moving away from screen, store in coredata
}
