//
//  ContentView.swift
//  InteractiveDismissDisabled
//
//  Created by Paul on 04.06.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var showingSheet = false
    @State private var user = User()
    var body: some View {
        Form {
            Section("User Profile") {
                Text(user.firstName)
                Text(user.secondName)
            }
            Button("Edit", action: { showingSheet.toggle() })
        }
        .sheet(isPresented: $showingSheet) {
            EditView(user: $user)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
