//
//  Item.swift
//  CS329E_FinalProject
//
//  Created by Samira Ravilisetty on 11/29/22.
//

import Foundation

public class NewItem {
    var newItem: String
    var price: Float
    var quantity: Int

    init(newItem: String, price: Float, quantity: Int) {
        self.newItem = newItem
        self.price = price
        self.quantity = quantity
    }
    
    func showList () -> String {
        return "\(self.newItem)"
    }

}
