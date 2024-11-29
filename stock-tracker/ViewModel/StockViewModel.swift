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
            // Putting an example APPL stock into the portfolio
            let newStock = StockModel(symbol: "AAPL", currentPrice: returnedQuote?.c, percentageChange: returnedQuote?.dp, sharesOwned: 1)
            DispatchQueue.main.async {
                self.stocks.append(newStock)
            }
        }
    }
    public func removeStock(stock: StockModel, sharesToRemove: Int) {
        guard let currentShares = stock.sharesOwned else {
                print("Error: Shares owned is nil")
                return
            }
        
        if let index = stocks.firstIndex(where: { $0.symbol == stock.symbol }) {
            // If shares to be removed would result in zero or fewer shares, remove the stock entirely
            if currentShares - sharesToRemove <= 0 {
                stocks.remove(at: index)
            } else {
                // Otherwise, update the sharesOwned
                // Modify the stock in the array directly
                stocks[index].sharesOwned = currentShares - sharesToRemove
            }
        }
    }
}
