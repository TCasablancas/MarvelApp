//
//  MarvelAPI.swift
//  MarvelApp
//
//  Created by Thyago on 31/03/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import Foundation

class MarvelAPI {
    
    static let shared = MarvelAPI(
        baseURL: URL(string: "https://gateway.marvel.com:443")!,
        privateKey: "76cb8d0bd88b49abe3e4d049e6064518062f998c",
        apiKey: "1951bc8fc24c16592930f688c6df1581"
        
    )

    lazy var characterService: MarvelService = {
        return MarvelService(baseURL: baseURL, privateKey: privateKey, apiKey: apiKey)
    }()
    
    private let baseURL: URL
    private let privateKey: String
    private let apiKey: String
    
    init(baseURL: URL, privateKey: String, apiKey: String) {
        self.baseURL = baseURL
        self.privateKey = privateKey
        self.apiKey = apiKey
    }
    
}
