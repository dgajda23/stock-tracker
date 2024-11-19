//
//  PortfolioTotalCard.swift
//  stock-tracker
//
//  Created by David Gajda on 10/28/24.
//

import SwiftUI

struct PortfolioTotalCard: View {
    
    @StateObject var stocksVM: StockViewModel
    var body: some View {
        VStack (alignment: .leading){
            Text("Portfolio Value")
                .padding(.top)
                .foregroundColor(Color.gray)
                .font(.title2)
            
            HStack (alignment: .top){
                Text("\(String(format: "%.2f", stocksVM.stocks.map({$0.currentPrice ?? 0.0}).reduce(0.0, +)))")
                    .foregroundColor(Color.white)
                    .bold()
                    .font(.system(size: 55))
                let averagePercentageChange = stocksVM.stocks
                    .compactMap { $0.percentageChange }
                    .reduce(0.0, +) / Double(stocksVM.stocks.count)
                
                Text("\(String(format: "%.2f", averagePercentageChange))%")
                    .foregroundColor(averagePercentageChange >= 0 ? Color.green : Color.red)
                    .bold()
                    .font(.title3)
            }
            
            Spacer()
            Spacer()
        }
        .frame(height: UIScreen.main.bounds.height / 4)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 40)
                .fill(Color.darkBlue)
        )
        .padding()
    }
}

//#Preview {
//    PortfolioTotalCard()
//}
