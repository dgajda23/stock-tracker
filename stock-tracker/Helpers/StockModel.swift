//
//  StockModel.swift
//  stock-tracker
//
//  Created by David Gajda on 10/28/24.
//

import Foundation

struct StockModel: Hashable {
    let symbol: String
    let currentPrice: Double?
    let percentageChange: Double?
}
