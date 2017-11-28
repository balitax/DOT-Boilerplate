//
//  APIManager.swift
//  MVVM Boilerplate
//
//  Created by Agus Cahyono on 27/11/17.
//  Copyright © 2017 Agus Cahyono. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    
    static var manager: SessionManager!
    
    static func fetch(
            url: String,
            method: HTTPMethod,
            parameters: Parameters = Parameters(),
            headers: HTTPHeaders = HTTPHeaders(),
            complete: @escaping (_ response: String?, _ success: Bool? )->()) {
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        
        APIManager.manager = Alamofire.SessionManager(configuration: configuration)
        
        APIManager.manager.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseString { response in
            
            if response.response?.statusCode == 200 {
                complete(response.result.value, true)
            } else {
               complete(response.result.value, false)
            }
        }
        
    }
    
}
