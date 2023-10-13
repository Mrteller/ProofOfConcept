//
//  SignUpView.swift
//  SwiftUIWithCombine
//
//  Created by Paul on 06.11.2022.
//
// Focused and field navigation up-down
// See: https://stackoverflow.com/questions/58422440/focus-on-the-next-textfield-securefield-in-swiftui/#68010785
// Toolbar item to hide keyboard
// https://stackoverflow.com/questions/56491386/how-to-hide-keyboard-when-using-swiftui/#63942065

// Still not clear how to dismiss onDrag and on tapping other areas than EditFields. Now used UIApplication kext

import SwiftUI

struct SignUpView: View {
    
    @StateObject private var userVM = UserVM()
    @State private var isShowingWelcome = false
    @FocusState private var focusedField: Field?
    
    var body: some View {
        Form {
            Section(footer: Text(userVM.usernameMessage).foregroundColor(.red)) {
                TextField("Username", text: $userVM.username)
                    .autocapitalization(.none)
                    .focused($focusedField, equals: .username)
            }
            Section(footer: Text(userVM.passwordMessage).foregroundColor(.red)) {
                SecureField("Password", text: $userVM.password) // Can use `Group`
                    .focused($focusedField, equals: .password)
                SecureField("Password again", text: $userVM.passwordAgain)
                    .focused($focusedField, equals: .password)
            }
            Section(footer: Text(userVM.emailMessage).foregroundColor(.red)) {
                TextField("Email", text: $userVM.email)
                    // .autocapitalization(.none) // Better use `.textContentType(.emailAddress)`
                    .textContentType(.emailAddress)
                    .focused($focusedField, equals: .email)
            }
            Section {
                Button(action: { signUp() }) {
                    Text("Sign up")
                }.disabled(!userVM.isValid)
            }
        }
        // This does not work
//        .gesture(TapGesture().onEnded({ val in
//            dismissKeyboard()
//        }), including: .all)
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                Button(action: focusPreviousField) {
                    Image(systemName: "chevron.up")
                }
                .disabled(!canFocusPreviousField()) // remove this to loop through fields
            }
            ToolbarItem(placement: .keyboard) {
                Button(action: focusNextField) {
                    Image(systemName: "chevron.down")
                }
                .disabled(!canFocusNextField()) // remove this to loop through fields
            }
            ToolbarItem(placement: .keyboard) {
                Button(action: dismissKeyboard) {
                    Image(systemName: "keyboard.chevron.compact.down")
                }
            }
        }
        .sheet(isPresented: $isShowingWelcome) {
            WelcomeView()
        }
        .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
    }
    
    func signUp() {
        isShowingWelcome = true
    }
}

private extension SignUpView {
    enum Field: Int, CaseIterable {
        case email, username, password
    }
    
    func focusPreviousField() {
        focusedField = focusedField.map {
            Field(rawValue: $0.rawValue - 1) ?? .password
        }
    }
    
    func focusNextField() {
        focusedField = focusedField.map {
            Field(rawValue: $0.rawValue + 1) ?? .email
        }
    }
    
    func canFocusPreviousField() -> Bool {
        guard let currentFocusedField = focusedField else {
            return false
        }
        return currentFocusedField.rawValue > 0
    }
    
    func canFocusNextField() -> Bool {
        guard let currentFocusedField = focusedField else {
            return false
        }
        return currentFocusedField.rawValue < Field.allCases.count - 1
    }
    
    func dismissKeyboard() {
        focusedField = nil
    }
}



// TODO: Compare with this
//private extension ProfileFocusedView {
//    
//    var hasReachedEnd: Bool {
//        focusedInput == Field.allCases.last
//    }
//    
//    var hasReachedStart: Bool {
//        focusedInput == Field.allCases.first
//    }
//    
//    func dismissKeyboard() {
//        focusedInput = nil
//    }
//    
//    func next() {
//        guard let currentInput = focusedInput,
//              let lastIndex = Field.allCases.last?.rawValue else { return }
//        let index = min(currentInput.rawValue + 1, lastIndex)
//        focusedInput = Field(rawValue: index)
//    }
//    
//    func previous() {
//        guard let currentInput = focusedInput,
//              let firstIndex = Field.allCases.first?.rawValue else { return }
//        
//        let index = max(currentInput.rawValue - 1, firstIndex)
//        focusedInput = Field(rawValue: index)
//    }
//}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}


extension UIApplication {
    func addTapGestureRecognizer() {
        guard let window = windows.first else { return }
        let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapGesture.requiresExclusiveTouchType = false
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        window.addGestureRecognizer(tapGesture)
    }
}

extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true // set to `false` if you don't want to detect tap during other gestures
    }
}
