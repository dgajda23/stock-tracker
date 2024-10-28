//
//  StockCard.swift
//  stock-tracker
//
//  Created by David Gajda on 10/28/24.
//

import SwiftUI

struct StockCard: View {
    let stockModel: StockModel
    var body: some View {
        // Stock cards
        VStack {
            HStack {
                Image(systemName: "apple.logo")
                    .font(.title)
                
                VStack {
                    Text("AAPL")
                        .bold()
                        .font(.title3)
                }
                
                Spacer()
                
                Text("2.3%")
                    .foregroundColor(.green)
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
        }
        .padding(.horizontal)
        .padding(.vertical)
        .frame(height: UIScreen.main.bounds.height / 4)
        .frame(width: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 40)
                .stroke(Color.black)
        )
    }
}

//#Preview {
//    StockCard()
//}
