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
    @State private var showSharePrompt = false
    @State private var selectedStock: StockSymbol?
    @State private var sharesInput: String = ""
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
                    selectedStock = symbol
                    showSharePrompt = true
                }) {
                    Text("Add to Portfolio")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
            }
            .padding(.vertical, 5)
        }
        .padding()
        .sheet(isPresented: $showSharePrompt) {
            ShareInputView(sharesInput: $sharesInput, selectedStock: selectedStock) {
                if let shares = Int(sharesInput), shares > 0, let selectedStock = selectedStock {
                    addStockToPortfolio(symbol: selectedStock, shares: shares)
                }
                showSharePrompt = false
            }
        }
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
    func addStockToPortfolio(symbol: StockSymbol, shares: Int) {
        // Fetch the current price and other data for the selected stock
        APIRequest.instance.getSymbolQuote(symbol: symbol.symbol) { returnedQuote in
            if let quote = returnedQuote {
                let newStock = StockModel(
                    symbol: symbol.symbol,
                    currentPrice: quote.c,
                    percentageChange: quote.dp,
                    sharesOwned: shares
                )
                DispatchQueue.main.async {
                    stocksVM.stocks.append(newStock)
                }
            }
        }
    }
    
    struct ShareInputView: View {
        @Binding var sharesInput: String
        var selectedStock: StockSymbol?
        var onAdd: () -> Void
        
        var body: some View {
            VStack(spacing: 20) {
                Text("Enter the number of shares to add: ")
                    .font(.headline)
                    .padding()
                
                TextField("Number of shares", text: $sharesInput)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.blue))
                
                Button("Add to Portfolio") {
                    onAdd()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
        }
    }
}
