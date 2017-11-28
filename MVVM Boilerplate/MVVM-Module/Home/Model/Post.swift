//
//  Post.swift
//  MVVM Boilerplate
//
//  Created by Agus Cahyono on 27/11/17.
//  Copyright © 2017 Agus Cahyono. All rights reserved.
//

import Foundation
import ObjectMapper

struct Post: Mappable {
    
    var id: Int?
    var title: String?
    var body: String?
    
    init() {
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id      <- map["id"]
        title   <- map["title"]
        body    <- map["body"]
    }
    
}
