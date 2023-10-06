//
//  ContentView.swift
//  RenderView
//
//  Created by Paul on 06/10/2023.
//

import SwiftUI

// An example view to render
struct RenderView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .foregroundStyle(.white)
            .padding()
            .background(.blue)
            .clipShape(Capsule())
    }
}

struct ContentView: View {
    @State private var text = "Your text here"
    @State private var uiImage = UIImage(systemName: "photo")
    @Environment(\.displayScale) private var displayScale
    
    var body: some View {
        let renderedImage = Image(uiImage: uiImage!)
        let textField = TextField("Enter some text", text: $text)
            .textFieldStyle(.roundedBorder)
            .padding()
            .background(.blue)
            .clipShape(Capsule())
        
        VStack {
            renderedImage
            
            ShareLink("Export", item: renderedImage, preview: SharePreview(Text("Shared image"), image: renderedImage))

            textField

        }
        .onChange(of: text) { _ in
            uiImage = RenderView(text: text).render(scale: displayScale)!
            // Note that the following will not work for some reason
            // uiImage = textField.render(scale: displayScale)!
            
            // This kind of works, but rendered size differs from original
            // uiImage = textField.snapshot()
        }
    }

}
// From iOS 16
extension View {
    /// Usually you would pass  `@Environment(\.displayScale) var displayScale`
    @MainActor func render(scale displayScale: CGFloat = 1.0) -> UIImage? {
        let renderer = ImageRenderer(content: self)

        renderer.scale = displayScale
        
        return renderer.uiImage
    }
    
}

// From iOS 15
extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        
        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}

#Preview {
    ContentView()
}
