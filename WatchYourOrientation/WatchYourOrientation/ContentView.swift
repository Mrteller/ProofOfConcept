//
//  ContentView.swift
//  WatchYourOrientation
//
//  Created by Paul on 20.10.2022.
//

import SwiftUI

struct ContentView: View {
    
    @Orientation var orientation
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .onChange(of: orientation) { _ in
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            windowScene?.requestGeometryUpdate(.iOS(interfaceOrientations: .portrait))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
