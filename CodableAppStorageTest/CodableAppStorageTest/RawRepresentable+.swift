//
//  RawRepresentable+.swift
//  CodableAppStorageTest
//
//  Created by Paul on 27/07/2023.
//

import Foundation

// This fails with `@AppStorage`
extension RawRepresentable where Self: Codable {
    
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode(Self.self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        // Causes error: BAD_EXEC
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}
