//
//  SignUpView.swift
//  SwiftUIWithCombine
//
//  Created by Paul on 06.11.2022.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject private var userVM = UserVM()
    @State var isShowingWelcome = false
    
    var body: some View {
        Form {
            Section(footer: Text(userVM.usernameMessage).foregroundColor(.red)) {
                TextField("Username", text: $userVM.username)
                    .autocapitalization(.none)
            }
            Section(footer: Text(userVM.passwordMessage).foregroundColor(.red)) {
                SecureField("Password", text: $userVM.password)
                SecureField("Password again", text: $userVM.passwordAgain)
            }
            Section {
                Button(action: { signUp() }) {
                    Text("Sign up")
                }.disabled(!userVM.isValid)
            }
        }
        .sheet(isPresented: $isShowingWelcome) {
            WelcomeView()
        }
    }
    
    func signUp() {
        isShowingWelcome = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
