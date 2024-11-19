//
//  SearchStockView.swift
//  stock-tracker
//
//  Created by David Gajda on 10/28/24.
//

import SwiftUI

struct SearchStockView: View {
    @State private var searchSymbol : String = ""
    @State private var stockSymbols: [StockSymbol] = []
    @StateObject var stocksVM: StockViewModel
    var body: some View {
        VStack {
            TextField("Ticker Symbol", text: $searchSymbol)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .stroke(Color.blue)
                ).padding()
                .textInputAutocapitalization(.never)
                .onSubmit {
                    fetchSymbols()
                }
            Divider()
            
            List(stockSymbols, id: \.symbol) { symbol in
                Text(symbol.symbol)
                    .font(.headline)
                Text(symbol.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("Type: \(symbol.type)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Button(action: {
                    addStockToPortfolio(symbol: symbol)
                }) {
                    Text("Add to Portfolio")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
            }
            .padding(.vertical, 5)
        }
        .padding()
        Text("Search View")
    }
    
    func fetchSymbols() {
        APIRequest.instance.getSymbolLookup(searchQuery: searchSymbol) { returnedLookup in
            if let lookup = returnedLookup {
                DispatchQueue.main.async {
                    self.stockSymbols = lookup.result
                }
            }
        }
    }
    func addStockToPortfolio(symbol: StockSymbol) {
        // Fetch the current price and other data for the selected stock
        APIRequest.instance.getSymbolQuote(symbol: symbol.symbol) { returnedQuote in
            if let quote = returnedQuote {
                let newStock = StockModel(
                    symbol: symbol.symbol,
                    currentPrice: quote.c,
                    percentageChange: quote.dp
                )
                DispatchQueue.main.async {
                    stocksVM.stocks.append(newStock)
                }
            }
        }
    }
}


//#Preview {
//    SearchStockView()
//}
