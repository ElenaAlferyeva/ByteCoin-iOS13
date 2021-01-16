//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

import Foundation
import CoreLocation

protocol CoinManagerDelegate {
    func didUpdateRate(_ coinManager: CoinManager, rate: Double)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "F43231D7-60D9-4075-9F77-AB33A27664E6"
    
    var delegate: CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String) -> Double {
        return 0.00
    }
    
    func fetchRate(currency: String) {

            let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
            performRequest(with: urlString)
        
    }
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    //delegate?.didFailWithError(error: error as! Error)
                    return
                }
                if let safeData = data {
                    if let currencyRate = parseJSON(safeData) {
                        delegate?.didUpdateRate(self, rate: currencyRate)
                        print(currencyRate)
                    }
                }
            }
            
            task.resume()
        }
        
    }
    
    func parseJSON (_ coinData: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
         let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let rate = decodedData.rate
            return rate

        } catch {
           // delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
