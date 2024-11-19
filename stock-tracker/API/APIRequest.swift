//
//  APIRequest.swift
//  stock-tracker
//
//  Created by David Gajda on 10/28/24.
//

import Foundation

class APIRequest{
    static let instance = APIRequest()
    
    private var url = "https://finnhub.io/api/v1/"
    private var apiToken = "&token=csfst7hr01qo4cffei4gcsfst7hr01qo4cffei50"
    
    public func getSymbolQuote(symbol:String, handler: @escaping(_ returnedQuote: Quote?) ->()) {
        let query: String = "quote?symbol=\(symbol)"
        let url = URL(string: url + query + apiToken)
        
        if let url = url {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("error getting a quote: \(error)")
                    return
                }
                
                guard let quoteData = data else{
                    print("Data not valid")
                    return
                }
                let returnedQuote = try? JSONDecoder().decode(Quote.self, from: quoteData)
                
                handler(returnedQuote)
            }
            task.resume()
        }
    }
    
    public func getSymbolLookup(searchQuery: String, handler: @escaping(_ returnedLookup: StockSymbolSearch?) -> ()) {
            let query: String = "search?q=\(searchQuery)"
            
            let url = URL(string: url + query + apiToken)
            
            if let url = url {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    if let error = error {
                        print("error searching for symbols: \(error)")
                        return
                    } else {
                        guard let searchData = data else {
                            print("symbol search not valid")
                            return
                        }
                        
                        let returnedSymbols = try? JSONDecoder().decode(StockSymbolSearch.self, from: searchData)
                        handler(returnedSymbols)
                    }
                }
                task.resume()
            }
        }
        
}
