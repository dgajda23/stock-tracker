//
//  PortfolioTotalCard.swift
//  stock-tracker
//
//  Created by David Gajda on 10/28/24.
//

import SwiftUI

struct PortfolioTotalCard: View {
    var body: some View {
        VStack (alignment: .leading){
            Text("Portfolio Value")
                .padding(.top)
                .foregroundColor(Color.gray)
                .font(.title2)
            
            HStack (alignment: .top){
                Text("1,789.27")
                    .foregroundColor(Color.white)
                    .bold()
                    .font(.system(size: 55))
                Text("4.6%")
                    .foregroundColor(Color.green)
                    .bold()
                    .font(.title3)
            }
            
            Spacer()
            Spacer()
            
            HStack {
                Button(action: {
                    print("Add stocks")
                }){
                    Text("ADD")
                        .foregroundColor(Color.white)
                        .bold()
                        .padding()
                        .padding(.horizontal)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color.green)
                        )
                }
                .padding(.bottom)
                .padding(.horizontal)
                
                Button(action: {
                    print("Remove stocks")
                }){
                    Text("REMOVE")
                        .foregroundColor(Color.white)
                        .bold()
                        .padding()
                        .padding(.horizontal)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color.red)
                        )
                }
                .padding(.bottom)
                .padding(.horizontal)
            }
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

#Preview {
    PortfolioTotalCard()
}
