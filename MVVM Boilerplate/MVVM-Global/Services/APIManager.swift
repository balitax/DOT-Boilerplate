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
    
    
    /// FETCH DATA FROM API
    ///
    /// - Parameters:
    ///   - url: URL API
    ///   - method: GET, PUT, UPDATE or POST
    ///   - parameters: parameters optional for alamofire data
    ///   - headers: header optional for alamofire data
    ///   - complete: complete callback
    static func didFetch(
            url: String,
            method: HTTPMethod,
            parameters: Parameters = Parameters(),
            headers: HTTPHeaders = HTTPHeaders(),
            complete: @escaping (_ response: String?, _ success: Bool? )->()) {
        
        // setup for timeout interval
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
    
    
    /// DID UPLOAD IMAGES
    ///
    /// - Parameters:
    ///   - url: url of API
    ///   - method: method of action =POST
    ///   - parameters: parameters of part data
    ///   - imageParameters: image for part data
    ///   - headers: headers of Alamofire
    ///   - complete: complete callback
    static func didUpload(
        url: String,
        method: HTTPMethod,
        parameters: Parameters = Parameters(),
        imageParameters: [UIImage]? = [UIImage](),
        headers: HTTPHeaders = HTTPHeaders(),
        complete: @escaping (_ response: String?, _ success: Bool? )->()) {
        
        // setup for timeout interval
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        
        APIManager.manager = Alamofire.SessionManager(configuration: configuration)
        
        // Do Upload
        APIManager.manager.upload(multipartFormData: { (multipartFormData) in
            
            // add parameters to multipart data
            for (key, value) in parameters {
                let valueAsString = value as! String
                multipartFormData.append(valueAsString.data(using: String.Encoding.utf8)!, withName: key)
            }
            
            // add image to multipart data
            var i = 0
            if imageParameters != nil {
                
                for image in imageParameters! {
                    let imageToData = UIImageJPEGRepresentation(image, 0.2)
                    multipartFormData.append(imageToData!, withName: "image", fileName: "image-\(i)", mimeType: "image/jpg")
                    i += 1
                }
                
            }
            
        },
        usingThreshold: UInt64.init(),
        to: url,
        method: method,
        headers: headers) { (result) in
            
            switch result {
            case .success(let upload, _, _):
                upload.responseString(completionHandler: { response in
                    
                    guard let responseString = response.result.value else {
                        return
                    }
                    
                    // callback success
                    complete(responseString, true)
                    
                })
                
            case .failure(_):
                complete("", false)
            }
        }
    }
    
}
