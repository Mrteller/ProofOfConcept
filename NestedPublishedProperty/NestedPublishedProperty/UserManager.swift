//
//  UserManager.swift
//  NestedPublishedProperty
//
//  Created by Paul on 30.09.2022.
//

import SwiftUI
import Combine

class UserManager: ObservableObject {
    @Published var favoriteLocationID: String = ""
    @Published var selectedLocationId: String = ""
    
    //@Injected(Container.tokenManager) var tokenManager
    var tokenManager = TokenManager()

    
    var cancellables = Set<AnyCancellable>()
    
    init(
        favoriteLocationID: String = ""
    ) {
        self.favoriteLocationID = favoriteLocationID
        //subscribe()
        tokenManager.objectWillChange
            .receive(on: RunLoop.main)
            .sink { [weak self] item in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }
}
