//
//  HeaderView.swift
//  stock-tracker
//
//  Created by David Gajda on 10/28/24.
//

import SwiftUI
import UIKit

struct HeaderView: View {
    @Binding var isShowingSearchSheet: Bool
    
    var body: some View {
        HStack {
            Text("Stock Tracker")
                .font(.largeTitle)
                .bold()
                .foregroundColor(Color.gold)
            
            Spacer()
            
            Button(action: {
                isShowingSearchSheet = true
            }) {
                Image(systemName: "magnifyingglass")
                    .accentColor(Color.gold)
                    .font(.title)
            }
        }
    }
}
