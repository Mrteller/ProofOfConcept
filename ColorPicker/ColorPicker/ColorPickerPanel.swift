//
//  ColorPickerPanel.swift
//  ColorPicker
//
//  Created by Paul on 20.05.2022.
//

import SwiftUI

struct ColorPickerPanel: UIViewControllerRepresentable {
    @Binding var color: Color
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIColorPickerViewController {
        let picker = UIColorPickerViewController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ picker: UIColorPickerViewController, context: Context) {
        picker.selectedColor = UIColor(color)
        picker.supportsAlpha = false
    }
    
    class Coordinator: NSObject, UIColorPickerViewControllerDelegate {
        var parent: ColorPickerPanel
        
        init(_ pageViewController: ColorPickerPanel) {
            self.parent = pageViewController
        }
        
        func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
            parent.color = Color(uiColor: viewController.selectedColor)
        }
    }
}

struct ColorPickerPanel_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerPanel(color: .constant(.accentColor))
    }
}
