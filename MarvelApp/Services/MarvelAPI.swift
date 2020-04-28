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
    static let pathComics = "/comics?"
    static let limit = 20
    static private let privateKey = "c218ac81e876a7cc28ca6d4b40abf88515682ee9"
    static private let publicKey = "dbb1aecc7a36337856edc5319ec3abd6"
    
    static func getCredentials() -> String {
        let ts      = "1587149596062"
        let hash    = "\(ts)\(privateKey)\(publicKey)".md5()
        
        let authParams = "\("ts=" + ts)\("&apikey=" + publicKey)\("&hash=" + hash)"
        return authParams
        
        //let authParams = ["ts": ts, "apikey": publicKey, "hash": hash]
        //return authParams.queryString!
    }
}
