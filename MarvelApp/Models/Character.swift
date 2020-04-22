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
    var urls: [CharacterURL]
    
    init?(map: Map) {
        id          = (try? map.value("id")) ?? 0
        name        = (try? map.value("name")) ?? ""
        description = (try? map.value("description")) ?? ""
        thumbnail   = (try? map.value("thumbnail")) ?? Thumbnail(map: map)!
        urls        = [(try? map.value("urls")) ?? CharacterURL(map: map)!]
    }
    
    mutating func mapping(map: Map) {
        id          <- map["id"]
        name        <- map["name"]
        description <- map["description"]
        thumbnail   <- map["thumbnail"]
        urls        <- map["urls"]
    }
    
    
}
