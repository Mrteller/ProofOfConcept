//
//  UserItem.swift
//  AvitoProbationerChallenge
//
//  Created by Paul on 29/08/2023.
//

import UIKit

struct UserItem: Hashable {
    let id: String
    let name: String
    let year: Int
    let amountPages: Int
    let cover: UIImage?

    init(item: Item) {
        self.id = item.id
        self.name = item.name
        self.year = item.year
        self.amountPages = item.amountPages
        self.cover = item.cover
    }
}
