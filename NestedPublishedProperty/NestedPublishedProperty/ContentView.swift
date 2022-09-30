//
//  ContentView.swift
//  NestedPublishedProperty
//
//  Created by Paul on 30.09.2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vm = UserManager(favoriteLocationID: "Moscow")
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(vm.tokenManager.accessToken)
        }
        .padding()
        .task {
            try? await Task.sleep(nanoseconds: 3000_000_000)
            vm.tokenManager.accessToken = "TTT" // UUID().uuidString
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
