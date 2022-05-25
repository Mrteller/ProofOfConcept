//
//  SemiRoundedRectange.swift
//  MessageBubbles
//
//  Created by Paul on 25.05.2022.
//

import SwiftUI

// see also: https://stackoverflow.com/questions/68883032/swiftui-how-to-combine-two-shapes-to-create-a-speech-bubble-with-strokes

struct SemiRoundedRectangle: Shape {
    var cornerRadius: CGFloat
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX+cornerRadius, y: rect.maxY))
        path.addArc(center: CGPoint(x: cornerRadius, y: rect.height - cornerRadius),
                    radius: cornerRadius,
                    startAngle: .degrees(90),
                    endAngle: .degrees(180), clockwise: false)
        path.addLine(to: CGPoint(x: 0, y: cornerRadius))
        path.addArc(center: CGPoint(x: cornerRadius, y: cornerRadius),
                    radius: cornerRadius,
                    startAngle: .degrees(180),
                    endAngle: .degrees(270), clockwise: false)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        
        return path
    }
    
}

struct TestView: View {
    var body: some View {
        HStack {
            Text("ايه الأخبار؟")
                .padding()
                .background(Color.green)
                //.flipped(.vertical)
                .clipShape(SemiRoundedRectangle(cornerRadius: 20.0).flipped())
            Spacer()
        }
        .padding()
    }
}

struct SemiRoundedRectange_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}


extension View {
    func flipped(_ axis: Axis = .horizontal, anchor: UnitPoint = .center) -> some View {
        switch axis {
        case .horizontal:
            return scaleEffect(CGSize(width: -1, height: 1), anchor: anchor)
        case .vertical:
            return scaleEffect(CGSize(width: 1, height: -1), anchor: anchor)
        }
    }
}

struct FlippedShape<Content>: Shape where Content : Shape {
    let content: Content
    func path(in rect: CGRect) -> Path {
        let flip = CGAffineTransform(scaleX: -1, y: 1)
        let position = flip.concatenating(CGAffineTransform(translationX: rect.width, y: 0))
        return content.path(in: rect).applying(position)
    }
}

extension Shape {
    func flipped1() -> FlippedShape<Self> {
        FlippedShape(content: self)
    }
    
    func flipped2() -> ScaledShape<Self> {
        scale(x: -1, y: 1, anchor: .center)
    }
}
