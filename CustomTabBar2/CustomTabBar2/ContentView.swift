//
//  ContentView.swift
//  CustomTabBar2
//
//  Created by Paul on 21.08.2022.
//

import SwiftUI
import TabBar

enum Item: Int, Tabbable {
    case first = 0
    case second
    case third
    
    var icon: String {
        switch self {
        case .first:  return "1.circle"
        case .second: return "2.circle"
        case .third:  return "1.circle"
        }
    }
    
    var title: String {
        switch self {
        case .first:  return "First"
        case .second: return "Second"
        case .third:  return "Third"
        }
    }
}

struct ContentView: View {
    @State private var selection: Item = .first
    @State private var visibility: TabBarVisibility = .visible
    
    var body: some View {
        TabBar(selection: $selection, visibility: $visibility) {
            Text("First")
                .tabItem(for: Item.first)
            
            Text("Second")
                .tabItem(for: Item.second)
            
            Text("Third")
                .tabItem(for: Item.third)
        }
        .tabItem(style: HorisontalTabItemStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct HorisontalTabItemStyle: TabItemStyle {
    
    @ViewBuilder
    public func tabItem(icon: String, title: String, isSelected: Bool) -> some View {
        let color: Color = isSelected ? .accentColor : .gray
        
        HStack(spacing: 5.0) {
            Image(systemName: icon)
                .renderingMode(.template)
            
            Text(title)
                .font(.system(size: 10.0, weight: .medium))
        }
        .foregroundColor(color)
    }
    
}
