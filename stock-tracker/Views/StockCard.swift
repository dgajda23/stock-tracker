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
                
                VStack {
                    Text(stockModel.symbol)
                        .bold()
                        .font(.title)
                    
                    // Display number of stocks owned
                    Text("Shares: \(stockModel.sharesOwned ?? 1)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Text(
                    (((stockModel.percentageChange ?? 0.0) >= 0.0) ? "+" : "")
                    +
                    "\(String(format: "%.2f" ,stockModel.percentageChange ?? 0.0))%"
                )
                .foregroundColor((stockModel.percentageChange ?? 0.0) >= 0.0 ? Color.emeraldGreen : Color.crimson)
                .bold()
                .font(.title3)
            }
            
            Spacer()
            HStack {
                // ZStack to overlay the rounded rectangle behind the text
                ZStack {
                    // RoundedRectangle as the background for the text
                    RoundedRectangle(cornerRadius: 8)
                        .fill((stockModel.percentageChange ?? 0.0) >= 0.0 ? Color.emeraldGreen : Color.crimson)
                        .frame(height: 40)
                        .frame(width: 200)
                        .padding(.horizontal, 8)
                    
                    // Price Text
                    Text("$\(String(format: "%.2f", stockModel.currentPrice ?? 0.0))")
                        .bold()
                        .font(.title)
                        .foregroundColor(.graphiteGray)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
            }
            
            HStack {
                Spacer()
                Button(action: {
                    onRemove()
                }) {
                    Text("REMOVE")
                        .foregroundColor(Color.white)
                        .bold()
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.darkCrimson)
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
                .fill(Color.obsidianGray)
                .stroke(Color.obsidianGray)
        )
    }
}
