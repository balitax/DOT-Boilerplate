//
//  Gallery.swift
//  MVVM Boilerplate
//
//  Created by Agus Cahyono on 07/12/17.
//  Copyright © 2017 Agus Cahyono. All rights reserved.
//

import Foundation
import ObjectMapper

struct Gallery: Mappable {
    
    var name: String?
    var error: String?
    var link: String?
    var success: Bool?
    
    init() {
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        name        <- map["data.name"]
        error       <- map["data.error"]
        link        <- map["data.link"]
        success     <- map["success"]
    }
    
}
