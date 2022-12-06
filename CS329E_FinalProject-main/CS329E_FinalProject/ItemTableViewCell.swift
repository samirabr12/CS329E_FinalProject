//
//  TableViewCell.swift
//  CS329E_FinalProject
//
//  Created by Samira Ravilisetty on 11/29/22.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var itemLabelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
 
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
