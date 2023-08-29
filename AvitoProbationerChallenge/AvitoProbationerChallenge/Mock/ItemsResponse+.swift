//
//  Item.swift
//  AvitoProbationerChallenge
//
//  Created by Paul on 29/08/2023.
//

import Foundation

extension ItemsResponse {
    static var sample: ItemsResponse? {
        guard let url = Bundle.main.url(forResource: "UserItems", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return nil
        }
        guard let response = try? JSONDecoder().decode(ItemsResponse.self, from: data) else {
            return nil
        }
        return response
    }
}
