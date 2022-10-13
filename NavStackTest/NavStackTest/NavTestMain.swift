//
//  ContentView.swift
//  NavStackTest
//
//  Created by Paul on 13.10.2022.
//

import SwiftUI



enum NavTestRoute: Hashable {
    case child
}

class NavTestService: ObservableObject {
    init() {
        print("[\(#function)][\(Self.self)]")
    }
    
    deinit {
        print("[\(#function)][\(Self.self)]")
    }
}

struct NavTestChildView: View {
    @EnvironmentObject var service: NavTestService
    
    init() {
        print("[\(#function)][\(Self.self)]")
    }
    
    var body: some View {
        Text(verbatim: "\(Self.self)")
    }
}


struct NavTestMainView: View {
    //let navTestService = NavTestService()
    var body: some View {
        NavigationStack {
            NavigationLink(value: NavTestRoute.child) {
                Text("Open child")
            }
            .navigationDestination(for: NavTestRoute.self) { route in
                switch route {
                case .child:
                    LazyView(NavTestChildView().environmentObject(NavTestService()))
                }
            }
        }
    }
}

struct NavTestMainView_Previews: PreviewProvider {
    static var previews: some View {
        NavTestMainView()
    }
}

struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
