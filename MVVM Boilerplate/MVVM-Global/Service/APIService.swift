//
//  APIService.swift
//  MVVM Boilerplate
//
//  Created by Agus Cahyono on 27/11/17.
//  Copyright © 2017 Agus Cahyono. All rights reserved.
//

import Foundation
import Alamofire

enum APIError: String, Error {
    case network = "No network connection. Please connect to the internet"
    case serveroverload = "Server is overload. Please be patient"
    case permissionDenied = "You don't have permission to access this service"
}

class APIService {
    static let baseURL = "https://jsonplaceholder.typicode.com/"
}

