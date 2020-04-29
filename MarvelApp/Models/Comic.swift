//
//  Comic.swift
//  MarvelApp
//
//  Created by Thyago on 28/04/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import Foundation
import ObjectMapper

struct Comic: Mappable {
    
    var title: String
    var description: String
    var prices: [Prices]
    var thumbnail: [Thumbnail]
    
    init?(map: Map) {
        title       = (try? map.value("title")) ?? ""
        description = (try? map.value("description")) ?? ""
        prices      = [(try? map.value("prices")) ?? Prices(map: map)!]
        thumbnail   = [(try? map.value("thumbnail")) ?? Thumbnail(map: map)!]
    }
    
    mutating func mapping(map: Map) {
        title       <- map["title"]
        description <- map["description"]
        prices      <- map["prices"]
        thumbnail   <- map["thumbnail"]
    }
}
