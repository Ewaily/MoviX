//
//  Data+Extensions.swift
//  MoviX
//
//  Created by Muhammad Ewaily on 12/02/2023.
//

import Foundation

extension Data {
    func decode<T: Decodable>(class: T.Type) -> Swift.Result<T, NetworkError> {
        let decoder = JSONDecoder()

        do {
            let decoded = try decoder.decode(T.self, from: self)
            return .success(decoded)
        } catch {
            print("decoding error: \(error)")
            return .failure(.decodingError)
        }
    }
}
