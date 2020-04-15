//
//  CharacterURL.swift
//  MarvelApp
//
//  Created by Thyago on 14/04/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import Foundation
import ObjectMapper

struct CharacterURL: Mappable {
    var type: String
    var url: String
    
    init?(map: Map) {
        type = (try? map.value("type")) ?? ""
        url  = (try? map.value("url")) ?? ""
    }
    
    mutating func mapping(map: Map) {
        type <- map["type"]
        url  <- map["url"]
    }
}
