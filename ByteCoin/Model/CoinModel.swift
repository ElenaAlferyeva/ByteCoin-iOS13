//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Elena Alferyeva on 06/01/2021.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

import Foundation

struct CoinModel {
    let rate: Double
    
    var rateString: String {
        return String(format: "%.1f", rate)
    }
    
}
