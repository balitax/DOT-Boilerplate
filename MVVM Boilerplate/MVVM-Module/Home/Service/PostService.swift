//
//  PostService.swift
//  MVVM Boilerplate
//
//  Created by Agus Cahyono on 27/11/17.
//  Copyright © 2017 Agus Cahyono. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

protocol PostServiceProtocol {
    func fetchPost(complete: @escaping (_ posts: [Post]?, _ error: APIError? )->() )
}

class PostService: PostServiceProtocol {
    
    var manager: SessionManager!
    
    /// Fetch Post
    ///
    /// - Parameter complete: array data
    func fetchPost(complete: @escaping ([Post]?, APIError?) -> ()) {
        
        let url = APIService.baseURL + "posts"
        APIManager.didFetch(
            url: url,
            method: .get) { (response, success) in
                
                if success == true {
                    if let responseJson = response {
                        let jsonModel = Mapper<Post>().mapArray(JSONString: responseJson)
                        complete(jsonModel!, nil)
                    }
                } else {
                    complete(nil, APIError.network)
                }
        }
    }
    
}
