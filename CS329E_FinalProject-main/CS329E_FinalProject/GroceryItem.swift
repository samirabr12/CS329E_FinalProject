//
//  GroceryItem.swift
//  CS329E_FinalProject
//
//  Created by Jennifer Lin on 11/29/22.
//

import Foundation
import CoreData

public class GroceryItem: NSManagedObject {
    var newItem: String = ""
    var price: Float?
    var quantity: Int = 0
    var itemID:NSManagedObjectID?

    func showList () -> String {
        return "\(String(describing: self.newItem))"
    }
}
