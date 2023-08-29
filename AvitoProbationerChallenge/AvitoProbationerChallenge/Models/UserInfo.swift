//
//  UserInfo.swift
//  AvitoProbationerChallenge
//
//  Created by Paul on 29/08/2023.
//

import Foundation

struct UserInfo {
    let id: String
    let userName: String
    let maxItemsAmount: Int
    var itemsAmount: Int
}

extension UserInfo: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
