//
//  SearchPageBodyVIew.swift
//  SearchFlow
//
//  Created by 老刁 on 2020/12/14.
//

import SwiftUI

struct SearchPageBodyView: View {
    @State var isSearching = false
    @State var searchText = ""
    @State var stockData:InventoryList = InventoryList()
    var body: some View {
        VStack {
            HStack {
                TextField(isSearching ? "" : "       Tap here to search", text:$searchText)
                    .frame(height: 30)
                    .padding(.horizontal,4)
                    .padding(.trailing, 20)
                    .onChange(of: searchText, perform: { value in
                        stockData.inventories.removeAll()
                        requestTest(value, completion: {response in
                            let decoder = JSONDecoder()
                            guard let data = response.data
                            else {
                                return
                            }
                            do {
                                print(data)
                                stockData = try decoder.decode(InventoryList.self, from:data)
                                
                            } catch {
                                print(error)
                            }
                            
                        })
                    })
            }//HStack
            .background(SF.BGColor)
            .padding(.horizontal)
            .cornerRadius(6.0)
            .overlay(
                HStack{
                    if !isSearching {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    if isSearching {
                        Button(
                            action: {
                                self.isSearching = false
                                searchText = ""
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }, label: {
                                Image(systemName: "multiply")
                                    .foregroundColor(Color.black)
                            }
                        )
                    }
                }//HStack
                .padding(.horizontal,24)
            )
            .onTapGesture{
                withAnimation {
                    self.isSearching.toggle()
                }
            }
            .offset(y: isSearching ? -20 : 0)
            .padding(.vertical, isSearching ? -20 : 0)
            
            Spacer()
                
                .navigationTitle(isSearching ? "" : "Search")
            if isSearching {
                if stockData.inventories.count == 0 {
                    Text("No result")
                        .offset(y:40)
                        .foregroundColor(Color.gray)
                }
                InventoryListView(stockData)
            }
        }
    }
}

struct SearchPageBodyView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPageBodyView()
    }
}
