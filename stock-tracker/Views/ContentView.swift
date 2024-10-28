//
//  ContentView.swift
//  stock-tracker
//
//  Created by David Gajda on 10/28/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var stockVM: StockViewModel = StockViewModel()
    
    @State private var isShowingStockSearchSheet: Bool = false
    
    var body: some View {
        VStack {
            HeaderView(isShowingSearchSheet: $isShowingStockSearchSheet)
                .padding()
            
            PortfolioTotalCard()
            
            StockListView(stockVM: stockVM)
            
            Spacer()
        }
        .padding()
        .edgesIgnoringSafeArea(.bottom)
        .sheet(isPresented: $isShowingStockSearchSheet) {
            SearchStockView()
        }
    }
}

#Preview {
    ContentView()
}
