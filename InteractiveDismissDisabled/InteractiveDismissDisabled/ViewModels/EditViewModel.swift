//
//  ContentViewModel.swift
//  InteractiveDismissDisabled
//
//  Created by Paul on 04.06.2022.
//

import Foundation

final class EditViewModel: ObservableObject {
    @Published var user: User
    private var original: User
    
    var isModified: Bool { return user != original }
    
    init(user: User) {
        self.user = user
        self.original = user
    }
}
