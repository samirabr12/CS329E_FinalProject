//
//  DatabaseTableViewCell.swift
//  CS329E_FinalProject
//
//  Created by Emily Wang on 12/4/22.
//

import UIKit

class DatabaseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellName: UILabel!
    @IBOutlet weak var cellPrice: UILabel!
    var delegate: UIViewController!
    var cellIndexPath: IndexPath!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.accessoryType = selected ? .checkmark : .none
        
        if selected {
            let dataVC = delegate as! addSelectedItems
            dataVC.addSelected(index: cellIndexPath)
        }
    }
//https://stackoverflow.com/questions/30516451/select-multiple-rows-in-tableview-and-tick-the-selected-ones
//swift select multiple items from tableview

}
