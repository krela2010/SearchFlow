//
//  MockData.swift
//  SearchFlow
//
//  Created by 老刁 on 2020/12/14.
//

import Foundation


struct InResponse : Codable {
    var inventories:[Inventory]

}
var inventories:[Inventory] = [
    Inventory(category: "Vacuum", brand: "Dyson", type:"V11", isInStock: false, price: 599.99),
    Inventory(category: "Vacuum", brand: "Dyson", type:"V10", isInStock: false, price: 399.99),
    Inventory(category: "Hair Dryer", brand: "Dyson", type:"Supersonic", isInStock: true, price: 599.99)
]




