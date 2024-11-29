//
//  StockListView.swift
//  stock-tracker
//
//  Created by David Gajda on 10/28/24.
//

import SwiftUI

struct StockListView: View {
    @StateObject var stockVM: StockViewModel
    @State private var showSharePrompt = false
    @State private var selectedStock: StockModel?
    @State private var sharesInput: String = ""
    var body: some View {
        VStack {
            HStack{
                Text("My Stocks")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.gold)
                Spacer()
            }
            .padding()
            
            ScrollView{
                VStack{
                    ForEach(stockVM.stocks, id: \.self) {stock in
                        StockCard(stockModel: stock){
                            showSharePrompt = true
                            selectedStock = stock
                        }
                    }
                }
            }
            .padding()
            .sheet(isPresented: $showSharePrompt) {
                ShareInputView(sharesInput: $sharesInput, selectedStock: selectedStock) {
                    if let shares = Int(sharesInput), shares > 0, let selectedStock = selectedStock {
                        removeStock(stock: selectedStock, sharesToRemove: shares)
                    }
                    showSharePrompt = false
                }
            }
        }
    }
    private func removeStock(stock: StockModel, sharesToRemove: Int) {
        guard let currentShares = stock.sharesOwned else {
            print("Error: Shares owned is nil")
            return
        }
        
        if let index = stockVM.stocks.firstIndex(where: { $0.symbol == stock.symbol }) {
            // If removing the shares would result in zero or fewer shares, remove the stock
            if currentShares - sharesToRemove <= 0 {
                stockVM.stocks.remove(at: index)
            } else {
                // Otherwise, update the shares owned for the stock
                stockVM.stocks[index].sharesOwned = currentShares - sharesToRemove
            }
        }
    }
    
    struct ShareInputView: View {
        @Binding var sharesInput: String
        var selectedStock: StockModel?
        var onAdd: () -> Void
        
        var body: some View {
            VStack(spacing: 20) {
                Text("Enter the number of shares to remove:")
                    .font(.headline)
                    .padding()
                
                TextField("Number of shares", text: $sharesInput)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.blue))
                
                Button("Remove from Portfolio") {
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
