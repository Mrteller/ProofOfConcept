//
//  ContentView.swift
//  CustomDisclosureGroup
//
//  Created by Paul on 03.07.2022.
//

import SwiftUI

struct ContentView: View {
    @State var isExpanded: Bool = false
    var body: some View {
        ScrollView {
            LazyVStack {
                DisclosureGroup("Disclosure", isExpanded: $isExpanded) {
                    Text("Hello, world!")
                        .padding()
                }
                .buttonStyle(DisclosureStyle(isExpanded: $isExpanded))

            }
            .padding(.horizontal)
        }
    }
}

struct DisclosureStyle: ButtonStyle {
    @Binding var isExpanded: Bool
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: isExpanded ? "chevron.down.circle" : "chevron.right.circle")
                .if(configuration.isPressed) { image in
                    image.symbolVariant(.fill)
                }
                .foregroundStyle(isExpanded ? .green : .accentColor)
            Spacer()
            let font = isExpanded ? Font.headline.monospaced() : .headline
            configuration.label
                .font(font).id(font)
                .overlay(alignment: .topTrailing) {
                    Rectangle().fill(.bar).frame(maxWidth: 30)
            }
            .foregroundStyle(isExpanded ? .green : .accentColor)
        }
        .background(.bar)
    }
}

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
