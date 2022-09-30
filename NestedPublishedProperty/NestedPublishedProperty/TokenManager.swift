//
//  TokenManager.swift
//  NestedPublishedProperty
//
//  Created by Paul on 30.09.2022.
//

import SwiftUI
class TokenManager: ObservableObject {
    /*@AppStorage("accessToken")*/  var accessToken: String = ""  {
        didSet {
            objectWillChange.send()
        }
    } 
    
    @AppStorage("refreshToken")  var refreshToken: String = "" {
        didSet {
            objectWillChange.send()
        }
    }
}
