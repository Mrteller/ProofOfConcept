//
//  NetworkAndAPILayer.swift
//  ModernAsyncCats
//
//  Created by Paul on 06.04.2022.
//

// This should be generally two layers plus view model. Simplfied for demo purposes.

import UIKit

func fetchCat() async throws -> Cat {
    let catURL = URL(string: "https://aws.random.cat/meow")!
    let (data, _) = try await URLSession.shared.data(from: catURL)
    return try JSONDecoder().decode(Cat.self, from: data)
}

func fetchImage() async throws -> UIImage {
    let cat = try await fetchCat()
    let (data, _) = try await URLSession.shared.data(from: cat.url)
    return UIImage(data: data)!
}

func fetchImages() async throws -> [UIImage] {
    async let first = fetchImage()
    async let second = fetchImage()
    async let third = fetchImage()
    return try await [first, second, third]
}

struct Cat: Identifiable, Codable {
    let file: String
    
    var id: String { file }
    var url: URL { URL(string: file)! }
}
