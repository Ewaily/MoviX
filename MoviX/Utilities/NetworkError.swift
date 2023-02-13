//
//  NetworkError.swift
//  MoviX
//
//  Created by Muhammad Ewaily on 12/02/2023.
//

import Foundation

enum NetworkError: Error {
    case invalidResponse
    case badUrl
    case decodingError
    case apiFailure
}
