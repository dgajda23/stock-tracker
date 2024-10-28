//
//  StockListView.swift
//  stock-tracker
//
//  Created by David Gajda on 10/28/24.
//

import SwiftUI

struct StockListView: View {
    @StateObject var stockVM: StockViewModel
    var body: some View {
        VStack {
            HStack{
                Text("My Stocks")
                    .font(.title)
                    .bold()
                    .foregroundColor(.darkBlue)
                Spacer()
            }
            .padding()
            
            ScrollView{
                VStack{
                    ForEach(stockVM.stocks, id: \.self) {stock in
                        StockCard(stockModel: stock)
                    }
//                    StockCard()
//                    StockCard()
                }
            }
            .padding()
        }
    }
}

//#Preview {
//    StockListView()
//}
