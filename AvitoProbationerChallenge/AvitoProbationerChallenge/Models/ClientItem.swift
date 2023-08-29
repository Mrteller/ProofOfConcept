//
//  ClientItem.swift
//  AvitoProbationerChallenge
//
//  Created by Paul on 29/08/2023.
//

import UIKit

struct ClientItem: Hashable {
    let id: String
    let name: String
    let year: Int
    let amountPages: Int
    let cover: UIImage?

    init(book: Item) {
        self.id = book.id
        self.name = book.name
        self.year = book.year
        self.amountPages = book.amountPages
        self.cover = book.cover
    }
}
