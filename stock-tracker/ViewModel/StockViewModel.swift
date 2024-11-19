//
//  StockViewModel.swift
//  stock-tracker
//
//  Created by David Gajda on 10/28/24.
//

import Foundation
import SwiftUI

class StockViewModel: ObservableObject {
    
    @Published var stocks: [StockModel] = [StockModel]()
    
    init(){
        self.fetchStockData()
    }
    
    public func fetchStockData() {
        APIRequest.instance.getSymbolQuote(symbol: "AAPL") { returnedQuote in
            let newStock = StockModel(symbol: "AAPL", currentPrice: returnedQuote?.c, percentageChange: returnedQuote?.dp)
            DispatchQueue.main.async {
                self.stocks.append(newStock)
            }
        }
    }
    public func removeStock(stock: StockModel) {
        if let index = stocks.firstIndex(of: stock) {
            stocks.remove(at: index)
        }
    }
}
