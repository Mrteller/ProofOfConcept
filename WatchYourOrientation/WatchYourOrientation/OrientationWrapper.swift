//
//  OrientationWrapper.swift
//  WatchYourOrientation
//
//  Created by Paul on 20.10.2022.
//

import SwiftUI

@propertyWrapper struct Orientation: DynamicProperty {
    @StateObject private var manager = OrientationManager.shared
    
    var wrappedValue: UIDeviceOrientation {
        manager.type
    }
}
