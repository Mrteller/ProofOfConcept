//
//  ContentView.swift
//  DeviceOrientationChange
//
//  Created by Paul on 25.05.2022.
//

class Model: ObservableObject {
    @Published var isLandScape: Bool = false
}

import SwiftUI

struct ContentView: View {
    @State private var isPortrait = false
    var body: some View {
        Group {
            if isPortrait {
                Text("PORTRAIT")
            } else {
                Text("LANDSCAPE")
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
            guard let scene = UIApplication.shared.keyWindow?.windowScene else { return }
            isPortrait = scene.interfaceOrientation.isPortrait
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Model())
    }
}


extension UIApplication {
    
    var keyWindow: UIWindow? {
        // Get connected scenes
        return UIApplication.shared.connectedScenes
        // Keep only active scenes, onscreen and visible to the user
            .filter { $0.activationState == .foregroundActive }
        // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
        // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
        // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
    
}
