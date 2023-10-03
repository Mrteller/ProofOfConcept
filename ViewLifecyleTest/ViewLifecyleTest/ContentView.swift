//
//  ContentView.swift
//  ViewLifecyleTest
//
//  Created by Paul on 02/10/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var isSecondViewShown = false
    var body: some View {
        Button("Show second") {
            isSecondViewShown.toggle()
        }
        .onAppear {
            appeared()
        }
        .fullScreenCover(isPresented: $isSecondViewShown, onDismiss: appeared) {
            Button("Close second") {
                isSecondViewShown.toggle()
            }
            .onAppear {
                print("Second appeared")
            }
        }
    }
    private func appeared() {
        print("First appeared")
    }
}

#Preview {
    ContentView()
}
