//
//  SearchPageMainView.swift
//  SearchFlow
//
//  Created by 老刁 on 2020/12/13.
//

import SwiftUI
//MARK:-  主页
struct SearchPageMainView: View {

    init() {
        HttpServerStubs().setUp()
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        
        NavigationView{
            ZStack{
                Color(.systemGray6).edgesIgnoringSafeArea(.all)
                SearchPageBodyView()
            }
        }
        
    }
}

struct SearchPageMainView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            
            SearchPageMainView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
            
            SearchPageMainView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
        }
    }
}


//MARK:-  价格标签
struct PriceChipsView: View {
   
    let isInStock:Bool
    let price:Double
    var body: some View {
        Text("$\(price,specifier: "%.2f")")
            .font(.caption)
            .padding(.horizontal, 8)
            .padding(.vertical, 5)
            .background(SF.BGColor)
            .foregroundColor(isInStock ? Color(.systemBlue) : Color(.systemGray))
            .cornerRadius(12.0)
    }
}
//MARK:-  商品列表
struct InventoryListView: View {
    var stockData:InventoryList
    var categories:[String:[Inventory]]{
        Dictionary(
            grouping:stockData.inventories,
            by:{$0.category}
        )
    }
    init(_ stockData:InventoryList) {
        self.stockData = stockData
    }
    var body: some View {
        List {
            ForEach(categories.keys.sorted(), id:\.self) {
                brand in
                Section(header:Text(brand)
                            .frame(height:20)) {
                    ForEach(self.categories[brand]!) { item in
                        HStack {
                            VStack(alignment:.leading) {
                                Text(item.type)
                                Text(item.isInStock ? "In-Stock" : "Out-of-stock")
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                            }
                            Spacer()
                            PriceChipsView(isInStock: item.isInStock, price: item.price)
                            
                        }
                    }
                }
            }
            .padding(.horizontal, 0)
        }
        .listStyle(InsetGroupedListStyle())
        .padding(.horizontal, -15)
    }
}


