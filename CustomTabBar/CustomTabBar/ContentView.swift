//
//  ContentView.swift
//  CustomTabBar
//
//  Created by Paul on 21.08.2022.
//

import SwiftUI

struct ContentView: View {
    init() {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        UIBarButtonItem.appearance().setTitlePositionAdjustment(UIOffset(horizontal: 30, vertical: 30), for: UIBarMetrics.default)
        UIBarButtonItem.appearance().imageInsets = UIEdgeInsets(top: 10, left: 20, bottom: 5, right: 5)

    }
    var body: some View {
        TabView {
            Text("Home Tab")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
//                    Image("sqr", label: Text("Home"))
//                        .resizable()
//                        .frame(width: 40, height: 40, alignment: .leading)
                    //Text("Home")
                    AttributedText(NSAttributedString("Some"))
                }
            
            Text("Bookmark Tab")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Label("Bookmark", systemImage: "bookmark.circle.fill")
                        .labelStyle(HorisontaLabelStyle())
                        .mask(Capsule())
                }
            
            Text("Video Tab")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    AnyView(HStack {
                        Image(systemName: "video.circle.fill")
                        Text("Video")
                    }
                    .drawingGroup()
                    .compositingGroup()
                            )
                }
            
            Text("Profile Tab")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    //Text(Image(systemName: "person.crop.circle") + "Profile")
                    AnyView(Text("Hello ") + Text(Image(systemName: "star")) + Text(" World!"))
                        .drawingGroup()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct HorisontaLabelStyle: LabelStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.icon
            configuration.title
        }
    }
}

struct AttributedText: View {
    @State private var size: CGSize = CGSize(width: 50, height: 50)
    let attributedString: NSAttributedString
    
    init(_ attributedString: NSAttributedString) {
        self.attributedString = attributedString
    }
    
    var body: some View {
        AttributedTextRepresentable(attributedString: attributedString, size: $size)
            .frame(width: size.width, height: size.height)
    }
    
    struct AttributedTextRepresentable: UIViewRepresentable {
        
        let attributedString: NSAttributedString
        @Binding var size: CGSize
        
        func makeUIView(context: Context) -> UILabel {
            let stackView = UIStackView()
            let label = UILabel()
            
            label.lineBreakMode = .byClipping
            label.numberOfLines = 1
            stackView.addArrangedSubview(label)
            
            return label
        }
        
        func updateUIView(_ uiView: UILabel, context: Context) {
//            (uiView.arrangedSubviews.first(where: { $0 is UILabel}) as? UILabel)?.attributedText = attributedString
            uiView.attributedText = attributedString
            
            DispatchQueue.main.async {
                size = uiView.sizeThatFits(uiView.superview?.bounds.size ?? .zero)
            }
        }
    }
}
