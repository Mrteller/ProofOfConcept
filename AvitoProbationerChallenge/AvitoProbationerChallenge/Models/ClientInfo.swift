//
//  ClientInfo.swift
//  AvitoProbationerChallenge
//
//  Created by Paul on 29/08/2023.
//

import Foundation

struct ClientInfo {
    let id: String
    let clientName: String
    let maxBooksAmount: Int
    var booksAmount: Int
}

extension ClientInfo: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
