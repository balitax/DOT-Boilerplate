//
//  DetailService.swift
//  MVVM Boilerplate
//
//  Created by Agus Cahyono on 28/11/17.
//  Copyright © 2017 Agus Cahyono. All rights reserved.
//

import Foundation
import Foundation
import Alamofire
import ObjectMapper

protocol DetailPostServiceProtocol {
    func fetchDetailPost(id: Int, complete: @escaping (_ posts: Post?, _ error: APIError? )->() )
}

class DetailPostService: DetailPostServiceProtocol {
    
    /// Fetch Detail Post
    ///
    /// - Parameter complete: array data
    func fetchDetailPost(id: Int, complete: @escaping (Post?, APIError?) -> ()) {
        let url = APIService.baseURL + "posts/\(id)"
        APIManager.fetch(
            url: url,
            method: .get) { (response, success) in
                if success == true {
                    if let responseJson = response {
                        let jsonModel = Mapper<Post>().map(JSONString: responseJson)
                        complete(jsonModel!, nil)
                    }
                } else {
                    complete(nil, APIError.network)
                }
        }
    }
    
}
