//
//  StockCard.swift
//  stock-tracker
//
//  Created by David Gajda on 10/28/24.
//

import SwiftUI

struct StockCard: View {
    let stockModel: StockModel
    var onRemove: () -> Void
    var body: some View {
        // Stock cards
        VStack {
            HStack {
                Image(systemName: "apple.logo")
                    .font(.title)
                
                VStack {
                    Text(stockModel.symbol)
                        .bold()
                        .font(.title3)
                }
                
                Spacer()
                
                Text(
                    (((stockModel.percentageChange ?? 0.0) >= 0.0) ? "+" : "")
                    +
                    "\(String(format: "%.2f" ,stockModel.percentageChange ?? 0.0))%"
                )
                .foregroundColor((stockModel.percentageChange ?? 0.0) >= 0.0 ? Color.green : Color.red)
                .bold()
                .font(.title3)
            }
            
            Spacer()
            HStack {
                Text("\(stockModel.currentPrice ?? 0.0)")
                    .bold()
                    .font(.title)
                
                Spacer()
                
                Text("Graph Here")
                
            }
            
            HStack {
                Spacer()
                Button(action: {
                    onRemove() // Call the removal action
                }) {
                    Text("REMOVE")
                        .foregroundColor(Color.white)
                        .bold()
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.red)
                        )
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical)
        .frame(height: UIScreen.main.bounds.height / 4)
        .frame(width: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 40)
                .stroke(Color.gray)
        )
    }
}

//#Preview {
//    StockCard()
//}
