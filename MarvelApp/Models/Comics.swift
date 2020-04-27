//
//  Comics.swift
//  MarvelApp
//
//  Created by Thyago on 24/04/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import Foundation
import ObjectMapper

struct Comics: Mappable {
    
    var available: Int
    var collectionURI: String
    var items: [Items]
    
    init?(map: Map) {
        available     = (try? map.value("availabe")) ?? 0
        collectionURI = (try? map.value("collectionURI")) ?? ""
        items         = [(try? map.value("items.name")) ?? Items(map: map)!]
    }
    
    mutating func mapping(map: Map) {
        available     <- map["available"]
        collectionURI <- map["collectionURI"]
        items         <- map["items.name"]
    }
}
