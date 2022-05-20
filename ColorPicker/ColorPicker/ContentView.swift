//
//  ContentView.swift
//  ColorPicker
//
//  Created by Paul on 19.05.2022.
//

import SwiftUI

struct ContentView: View {
    @State var color: Color = .blue
    var body: some View {
        VStack {
        ColorPicker(selection: $color) {
            Label("Pallete", systemImage: "paintpalette")
                .allowsHitTesting(true)
                .accessibilityAddTraits(.isButton)
        }
            CustomColorPicker(color: $color, labelText: "custom")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
