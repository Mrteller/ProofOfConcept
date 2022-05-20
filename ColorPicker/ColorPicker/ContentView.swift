//
//  ContentView.swift
//  ColorPicker
//
//  Created by Paul on 19.05.2022.
//

import SwiftUI

struct ContentView: View {
    @State var color: Color = .blue
    @State var isColorPickerPresented = false
    var body: some View {
        VStack {
            Button {
                isColorPickerPresented = true
            } label: {
                ColorPicker(selection: $color) {
                    Label("Pallete", systemImage: "paintpalette")
                        .allowsHitTesting(true)
                        .accessibilityAddTraits(.isButton)
                }
            }
        }
        .sheet(isPresented: $isColorPickerPresented) {
            ZStack (alignment: .topTrailing) {
                ColorPickerPanel(color: $color)
                Button {
                    isColorPickerPresented = false
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.tint, .secondary)
                        .font(.title)
                }
                .offset(x: -10, y: 10)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
