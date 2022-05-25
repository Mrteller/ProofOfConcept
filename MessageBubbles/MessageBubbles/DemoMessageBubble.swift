//
//  DemoMessageBubble.swift
//  MessageBubbles
//
//  Created by Paul on 25.05.2022.
//

import SwiftUI

struct MessageBubble<Content>: View where Content: View {
    let isRight: Bool
    let content: () -> Content
    
    var body: some View {
        HStack {
            if isRight {
                Spacer()
            }
            content().clipShape(MessageBubbleShape(isRight: isRight))
            //content().padding().background(.green, in: MessageBubbleShape(isRight: isRight))
            if !isRight {
                Spacer()
            }
        }.padding([!isRight ? .leading : .trailing, .top, .bottom], 20)
            .padding(isRight ? .leading : .trailing, 60)
    }
}

struct MessageBubbleShape: Shape {
    
    let isRight: Bool
    
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        let path = Path { p in
            p.move(to: CGPoint(x: 25, y: height))
            p.addLine(to: CGPoint(x:  20, y: height))
            p.addCurve(to: CGPoint(x: 0, y: height - 20),
                       control1: CGPoint(x: 8, y: height),
                       control2: CGPoint(x: 0, y: height - 8))
            p.addLine(to: CGPoint(x: 0, y: 20))
            p.addCurve(to: CGPoint(x: 20, y: 0),
                       control1: CGPoint(x: 0, y: 8),
                       control2: CGPoint(x: 8, y: 0))
            p.addLine(to: CGPoint(x: width - 21, y: 0))
            p.addCurve(to: CGPoint(x: width - 4, y: 20),
                       control1: CGPoint(x: width - 12, y: 0),
                       control2: CGPoint(x: width - 4, y: 8))
            p.addLine(to: CGPoint(x: width - 4, y: height - 11))
            p.addCurve(to: CGPoint(x: width, y: height),
                       control1: CGPoint(x: width - 4, y: height - 1),
                       control2: CGPoint(x: width, y: height))
            p.addLine(to: CGPoint(x: width + 0.05, y: height - 0.01))
            p.addCurve(to: CGPoint(x: width - 11, y: height - 4),
                       control1: CGPoint(x: width - 4, y: height + 0.5),
                       control2: CGPoint(x: width - 8, y: height - 1))
            p.addCurve(to: CGPoint(x: width - 25, y: height),
                       control1: CGPoint(x: width - 16, y: height),
                       control2: CGPoint(x: width - 20, y: height))
            
        }
        
        if isRight {
            return path
        } else {
            let flip = CGAffineTransform(scaleX: -1, y: 1)
            let position = flip.concatenating(CGAffineTransform(translationX: rect.width, y: 0))
            
            return path.applying(position)
        }
        
    }
}

struct MessageTextBody: View {
    init(_ message: String) {
        self.message = message
    }
    
    let message: String
    var body: some View {
        Text(message)
            .padding(.all)
            .foregroundColor(.primary)
            .background(.quaternary)
    }
}


struct DemoMessageBubble: View {
    var body: some View {
        ScrollView {
            VStack {
                MessageBubble(isRight: false) {
                    MessageTextBody("Incomming message")
                }
                MessageBubble(isRight: true) {
                    MessageTextBody("Outcomming message")
                }
                MessageBubble(isRight: true) {
                    MessageTextBody("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse ut semper quam. Phasellus non mauris sem. Donec sed fermentum eros. Donec pretium nec turpis a semper. ")
                }
            }
        }
    }
}

struct MessageBubbles_Previews: PreviewProvider {
    static var previews: some View {
        DemoMessageBubble()
    }
}

extension Shape {
    func flipped(_ axis: Axis = .horizontal, anchor: UnitPoint = .center) -> ScaledShape<Self> {
        switch axis {
        case .horizontal:
            return scale(x: -1, y: 1, anchor: anchor)
        case .vertical:
            return scale(x: 1, y: -1, anchor: anchor)
        }
        
    }
}


