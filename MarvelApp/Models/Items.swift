//
//  Items.swift
//  MarvelApp
//
//  Created by Thyago on 24/04/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import Foundation
import ObjectMapper

struct Items: Mappable {
    
    var resourceURI: String
    var name: String
    
    init?(map: Map) {
        resourceURI = (try? map.value("resourceURI")) ?? ""
        name        = (try? map.value("name")) ?? ""
    }
    
    mutating func mapping(map: Map) {
        resourceURI <- map["resourceURI"]
        name        <- map["name"]
    }
}
