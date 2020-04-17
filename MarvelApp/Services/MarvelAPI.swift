//
//  MarvelAPI.swift
//  MarvelApp
//
//  Created by Thyago on 14/04/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import Foundation
import CryptoSwift

class MarvelAPI {
    
    static let basePath = "https://gateway.marvel.com/v1/public"
    static let pathCharacters = "/characters?"
    static let limit = 500
    static private let privateKey = "76cb8d0bd88b49abe3e4d049e6064518062f998c"
    static private let publicKey = "1951bc8fc24c16592930f688c6df1581"
    
    static func getCredentials() -> String {
        let ts      = "1586905779.7129622"
        let hash    = "\(ts)\(privateKey)\(publicKey)".md5()
        
        let authParams = ["ts": ts, "apiKey": publicKey, "hash": hash]
        return authParams.queryString!
    }
}
