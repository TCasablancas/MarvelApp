//
//  Thumbnail.swift
//  MarvelApp
//
//  Created by Thyago on 14/04/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import Foundation
import ObjectMapper

struct Thumbnail: Mappable {
    var path: String
    var ext: String
    
    init?(map: Map) {
        path = (try? map.value("path")) ?? ""
        ext  = (try? map.value("extension")) ?? ""
    }
    
    mutating func mapping(map: Map) {
        path <- map["path"]
        ext  <- map["extension"]
    }
    
    func getUrl() -> String {
        return path + "." + ext
    }
}

