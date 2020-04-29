//
//  RequestComic.swift
//  MarvelApp
//
//  Created by Thyago on 27/04/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class RequestComic: Request {
    
    
    
    func loadComic(name: String?, page: Int = 0, onComplete: @escaping (_ response: ResponseMarvelInfo) -> Void) {
        let offset = page * MarvelAPI.limit
        var queryParams: [String:String] = ["offset": String(offset), "limit": String(MarvelAPI.limit)]
        if let name = name, !name.isEmpty {
            queryParams["nameStartsWith"] = name.replacingOccurrences(of: " ", with: "")
        }
        
        var character: Character?
        
        let url = MarvelAPI.basePath + "/characters" + "\(character?.id)" + MarvelAPI.pathComics + queryParams.queryString! + MarvelAPI.getCredentials()
        Alamofire.request(url).responseJSON { (data: DataResponse<Any>) -> Void in
            let statusCode = data.response?.statusCode
            switch data.result {
            case .success(let value):
                let resultValue = value
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
