//
//  DeviceOrientationChangeApp.swift
//  DeviceOrientationChange
//
//  Created by Paul on 25.05.2022.
//

import SwiftUI

@main
struct DeviceOrientationChangeApp: App {
    var model = Model()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
    }
}
