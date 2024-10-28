//
//  JSONDecoder.swift
//  stock-tracker
//
//  Created by David Gajda on 10/28/24.
//

import Foundation

struct Quote: Decodable {
    // From response from Finnhub
    // Current price
    let c: Double
    // Change
    let d: Double
    // Percent change
    let dp: Double
    // High price of day
    let h: Double
    // Low price of day
    let l: Double
    // Open price of day
    let o: Double
    // Previous close price
    let pc: Double
    // Time
    let t: Double
}
