//
//  RequestCharacter.swift
//  MarvelApp
//
//  Created by Thyago on 14/04/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class RequestCharacter: Request {
    
    func loadCharacters(name: String?, page: Int = 0, onComplete: @escaping (_ response: ResponseMarvelInfo) -> Void) {
        let offset = page * MarvelAPI.limit
        var queryParams: [String:String] = ["offset": String(offset), "limit": String(MarvelAPI.limit)]
        if let name = name, !name.isEmpty {
            queryParams["nameStartsWith"] = name.replacingOccurrences(of: " ", with: "")
        }
        
        let url = MarvelAPI.basePath + MarvelAPI.pathCharacters + queryParams.queryString! + MarvelAPI.getCredentials()
        Alamofire.request(url).responseJSON { (response) in
            let statusCode = response.response?.statusCode
            switch response.result {
            case .success(let value):
                let resultValue = value as? [String:Any]
                if statusCode == 200 {
                    let model = Mapper<MarvelInfo>().map(JSONObject: resultValue)
                    onComplete(.success(model: model!))
                }
            case .failure(let error):
                let errorCode = error._code
                if errorCode == -1009 {
                    let erro = ServerError(msgError: error.localizedDescription, statusCode: errorCode)
                    onComplete(.noConnection(description: erro))
                } else if errorCode == -1001 {
                    let erro = ServerError(msgError: error.localizedDescription, statusCode: errorCode)
                    onComplete(.timeOut(description: erro))
                }
            }
        }
    }
}
