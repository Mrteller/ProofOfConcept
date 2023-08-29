//
//  Item.swift
//  AvitoProbationerChallenge
//
//  Created by Paul on 29/08/2023.
//

import UIKit

struct Item: Hashable, Codable, Identifiable {
    let id: String
    let title: String
    let price: String
    let description: String?
    let location: String
    let imageURL: String
    let createdDate: String
    
    
    enum CodingKeys: String, CodingKey {
        case id, title, price, description, location
        case imageURL = "image_url"
        case createdDate = "created_date"
    }
}

struct ItemsResponse: Codable {
    let advertisements: [Item]
}
