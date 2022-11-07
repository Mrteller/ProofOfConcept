//
//  ContentView.swift
//  SimplestSignUpView
//
//  Created by Paul on 06.11.2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var signUpVM = SignUpVM()
    @State var isShowingWelcome = false
    
    var body: some View {
        Form {
            Section {
                TextField("Email", text: $signUpVM.email)
                    .autocapitalization(.none)
            }
            Section {
                SecureField("Password", text: $signUpVM.password1)
                SecureField("Password again", text: $signUpVM.password2)
                SecureField("Password again", text: $signUpVM.password3)
                SecureField("Password again", text: $signUpVM.password4)
                SecureField("Password again", text: $signUpVM.password5)
                SecureField("Password again", text: $signUpVM.password6)
            }
            Section {
                Button(action: { }) {
                    Text("Sign up")
                }.disabled(!signUpVM.isValid)
            }
        }
    }
}

import Combine
import CombineExt

final class SignUpVM: ObservableObject {
    @Published var email: String = ""
    @Published var password1: String = ""
    @Published var password2: String = ""
    @Published var password3: String = ""
    @Published var password4: String = ""
    @Published var password5: String = ""
    @Published var password6: String = ""
    
    @Published var isValid = false
 
// Does not work
//    var isValidPublisher: AnyPublisher<Bool, Never> {
//        [$password1, $password2, $password3, $password4]
//            .combineLatest()
//            .allSatisfy { passwords in
//                print(passwords)
//                return passwords.allSatisfy { !$0.isEmpty }
//
//            }
//            .eraseToAnyPublisher()
//    }
    
    var isValidPublisher: AnyPublisher<Bool, Never> {
        $email.combineLatest($password1)
            .map { [$0.0, $0.1] }
            .eraseToAnyPublisher()
            .allSatisfy { passwords in
                print(passwords)
                return passwords.allSatisfy { !$0.isEmpty }
                
            }
            .eraseToAnyPublisher()
    }
    
    private var cancellableSet: Set<AnyCancellable> = []
    
//    lazy var su: AnyCancellable = [email.publisher, password1.publisher, password2.publisher, password3.publisher, password4.publisher]
//        .combineLatest()
//        .sink(receiveValue: { print("combineLatest: \($0)") })
    
    init() {
//        isValidPublisher
//            .receive(on: RunLoop.main)
//            .assign(to: \.isValid, on: self)
//            .store(in: &cancellableSet)
        
        
        [$email, $password1, $password2, $password3, $password4, $password5, $password6]
            .combineLatest()
            .map { $0.allSatisfy({ !$0.isEmpty })}
            .assign(to: \.isValid, on: self)
            .store(in: &cancellableSet)
        
        
//        [$email, $password1, $password2, $password3, $password4]
//            .combineLatest()
//            .allSatisfy { passwords in
//                print(passwords)
//                return passwords.allSatisfy { !$0.isEmpty }
//
//            }
//            .assign(to: \.isValid, on: self)
//            .store(in: &cancellableSet)
        

        
//        let first = PassthroughSubject<Bool, Never>()
//        let second = PassthroughSubject<Bool, Never>()
//        let third = PassthroughSubject<Bool, Never>()
//        let fourth = PassthroughSubject<Bool, Never>()
//
//        let subscription = [first, second, third, fourth]
//            .combineLatest()
//            .sink(receiveValue: { print("combineLatest: \($0)") })
//
//        first.send(true)
//        second.send(true)
//        third.send(true)
//        fourth.send(true)
//
//        first.send(false)
    }
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
