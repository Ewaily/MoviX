//
//  RequestModel.swift
//  MoviX
//
//  Created by Muhammad Ewaily on 12/02/2023.
//

import Foundation

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol RequestModel {
    var method: RequestMethod { get }
    var path: String { get }
    var headers: [String: String]? { get }
    var paramters: [String: Any]? { get }
    var requestBodyParemeters: [String: Any]? { get }
}
