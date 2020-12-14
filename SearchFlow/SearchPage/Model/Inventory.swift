//
//  Inventory.swift
//  SearchFlow
//
//  Created by 老刁 on 2020/12/14.
//

import Foundation
import Combine


struct InventoryList : Codable {
    var inventories:[Inventory] = []
}

struct Inventory : Codable {
    
    var category:String
    var brand:String
    var type:String
    var isInStock:Bool
    var price:Double = 0.0

}

extension Inventory : Identifiable {
    var id: UUID{return UUID()}
}




