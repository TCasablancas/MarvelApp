//
//  MarvelInfo.swift
//  MarvelApp
//
//  Created by Thyago on 14/04/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import Foundation
import ObjectMapper

struct MarvelInfo: Mappable {
    var code: Int
    var status: String
    var data: MarvelData
    
    init?(map: Map) {
        code   = (try? map.value("code")) ?? 0
        status = (try? map.value("status")) ?? ""
        data   = (try? map.value("data")) ?? MarvelData(map: map)!
    }
    
    mutating func mapping(map: Map) {
        code   <- map["code"]
        status <- map["status"]
        data   <- map["data"]
    }
}
