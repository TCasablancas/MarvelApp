//
//  Request.swift
//  MarvelApp
//
//  Created by Thyago on 14/04/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import Foundation
import Alamofire

class Request {
    let alamofireManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        
        configuration.timeoutIntervalForRequest = 10000
        configuration.timeoutIntervalForResource = 10000
        
        return SessionManager(configuration: configuration )
    }()
}
