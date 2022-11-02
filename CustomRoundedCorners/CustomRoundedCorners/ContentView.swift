//
//  ContentView.swift
//  CustomRoundedCorners
//
//  Created by Paul on 02.11.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .background(Color.green)
        .cornerRadius(20, corners: [.bottomLeft], borderWidth: 4)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner, borderWidth: CGFloat = 0, borderColor: Color = .accentColor) -> some View {
        let shape = RoundedCorner(radius: radius, corners: corners)
        return clipShape(shape)
            .overlay {
                shape
                    .stroke(style: .init(lineWidth: borderWidth, lineJoin: .round))
                    .foregroundColor(borderColor)
            }
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        path.close()
        return Path(path.cgPath)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
