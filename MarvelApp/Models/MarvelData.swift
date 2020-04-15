//
//  MarvelData.swift
//  MarvelApp
//
//  Created by Thyago on 14/04/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import Foundation
import ObjectMapper

struct MarvelData: Mappable {
    var offset: Int
    var limit: Int
    var total: Int
    var count: Int
    var results: [Character]
    
    init?(map: Map) {
        offset  = (try? map.value("offset")) ?? 0
        limit   = (try? map.value("offset")) ?? 0
        total   = (try? map.value("offset")) ?? 0
        count   = (try? map.value("offset")) ?? 0
        results = [(try? map.value("results")) ?? Character(map: map)!]
    }
    
    mutating func mapping(map: Map) {
        offset  <- map["total_count"]
        limit   <- map["limit"]
        total   <- map["total"]
        count   <- map["count"]
        results <- map["results"]
    }
}
