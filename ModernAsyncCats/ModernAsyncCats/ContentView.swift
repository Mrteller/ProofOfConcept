//
//  ContentView.swift
//  ModernAsyncCats
//
//  Created by Paul on 06.04.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var image: UIImage?
    @State private var images: [UIImage]?
    
    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            Button("Reload one") {
                Task {
                    image = try? await fetchImage()
                }
            }
            if let images = images {
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack {
                        ForEach(images, id: \.hashValue) { image in
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                }
            }
            HStack {
                Button("Reload three at once") {
                    Task {
                        images = try? await fetchImages()
                    }
                }
                .frame(maxWidth: .infinity)
                Button("Reload three one by one") {
                    Task {
                        images = [try! await fetchImage()]
                        images? += [try! await fetchImage()]
                        images? += [try! await fetchImage()]
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .task {
            (image, images) = await (try? fetchImage(), try? fetchImages())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

