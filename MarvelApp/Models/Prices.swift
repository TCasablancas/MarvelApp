//
//  Prices.swift
//  MarvelApp
//
//  Created by Thyago on 28/04/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import Foundation
import ObjectMapper

struct Prices: Mappable {
    
    var type: String
    var price: Double
    
    init?(map: Map) {
        type  = (try? map.value("value")) ?? ""
        price = (try? map.value("price")) ?? 0.0
    }
    
    mutating func mapping(map: Map) {
        type  <- map["type"]
        price <- map["price"]
    }
}
