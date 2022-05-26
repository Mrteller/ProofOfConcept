//
//  ContentView.swift
//  ColorPicker
//
//  Created by Paul on 19.05.2022.
//

import SwiftUI

struct ContentView: View {
    @State var color: Color = .accentColor
    @State var isColorPickerPresented = false
    let gradient = Gradient(stops: [.init(color: .red, location: 0), .init(color: .red, location: 0.49), .init(color: .green, location: 0.5), .init(color: .green, location: 1)])
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
        .background(LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .topTrailing))
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
