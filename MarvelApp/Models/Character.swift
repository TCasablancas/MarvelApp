//
//  Character.swift
//  MarvelApp
//
//  Created by Thyago on 14/04/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import Foundation
import ObjectMapper

struct Character: Mappable {
    var id: Int
    var name: String?
    var description: String
    var thumbnail: Thumbnail
    var comics: [Comics]
    var series: [Series]
    
    init?(map: Map) {
        id          = (try? map.value("id")) ?? 0
        name        = (try? map.value("name")) ?? ""
        description = (try? map.value("description")) ?? ""
        thumbnail   = (try? map.value("thumbnail")) ?? Thumbnail(map: map)!
        comics      = [(try? map.value("comics")) ?? Comics(map: map)!]
        series      = [(try? map.value("series")) ?? Series(map: map)!]
    }
    
    mutating func mapping(map: Map) {
        id          <- map["id"]
        name        <- map["name"]
        description <- map["description"]
        thumbnail   <- map["thumbnail"]
        comics      <- map["comics"]
        series      <- map["series"]
    }
    
    
}
