import SwiftUI

class CPicker {
    let cw = UIColorWell(frame: CGRect(origin: .zero, size: CGSize(width: 20, height: 20)))
    let label = UILabel()
    
}

struct CustomColorPicker: UIViewRepresentable {
    @Binding var color: Color
    let labelText: String
    
    private let cw = UIColorWell()
    private let label = UIButton(type: .custom)
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UIStackView {
        //label.addTarget(cw, action: Selector(cw.actions(forTarget: cw, forControlEvent: .touchUpInside)![0]), for: .touchUpInside)
        cw.selectedColor = UIColor(color)
        label.setTitle(labelText, for: .normal)
        label.layer.borderColor = UIColor.red.cgColor
        label.layer.borderWidth = 3
        //label.bounds = CGRect(origin: .zero, size: CGSize(width: 60, height: 50))
        //print(cw.value(forKeyPath: "_style._button"))
        cw.addTarget(
            context.coordinator,
            action: #selector(Coordinator.updateCurrentPage(sender:)),
            for: .valueChanged)
//        label.addTarget(
//            label,
//            action: Selector((cw.value(forKey: "_style") as! UIControl).actions(forTarget: cw, forControlEvent: .touchUpInside)![0]),
//            for: .touchUpInside)
        label.addTarget(context.coordinator,
                        action: #selector(Coordinator.labelPressed(sender:)), for: .touchUpInside)
        let stv = UIStackView(arrangedSubviews: [label, cw])
        stv.distribution = .fillProportionally
        print(#selector(Coordinator.labelPressed(sender:)))
        return stv
        
    }
    
    func updateUIView(_ uiView: UIStackView, context: Context) {
        label.setTitle(labelText, for: .normal)
        cw.selectedColor = UIColor(color)
    }
      
    class Coordinator: NSObject {
        var customColorPicker: CustomColorPicker
        
        init(_ customColorPicker: CustomColorPicker) {
            self.customColorPicker = customColorPicker
        }
        
        @objc func updateCurrentPage(sender: UIColorWell) {
            guard let selectedColor = sender.selectedColor else { return }
            customColorPicker.color = Color(uiColor: selectedColor)
        }
        
        @objc func labelPressed(sender: UIButton) {
            // This does not present color picker controller
            customColorPicker.cw.sendActions(for: .touchDown)
            customColorPicker.cw.sendActions(for: .allEvents)
            // customColorPicker.cw.sendAction(Selector("invokeColorPickerWithSender:"), to: customColorPicker.cw, for: nil)
        }
    }
    
}

struct CustomColorPicker_Previews: PreviewProvider {
    static var previews: some View {
        CustomColorPicker(color: .constant(.brown), labelText: "labelText")
    }
}
