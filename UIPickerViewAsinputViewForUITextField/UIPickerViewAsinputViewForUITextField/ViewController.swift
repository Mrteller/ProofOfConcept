//
//  ViewController.swift
//  UIPickerViewAsinputViewForUITextField
//
//  Created by Paul on 08.04.2022.
//

import UIKit

struct TimeOption {
    var hours = 0
    var minutes = 0
    var seconds = 0
}

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPicker()
    }
    
    var currentTime = TimeOption() {
        didSet {
            textField.text = String(format: "%d:%d:%d", currentTime.hours, currentTime.minutes, currentTime.seconds)
        }
    }
    
//    override func loadView() {
//        self.view = UIView()
//        self.view.backgroundColor = .white
//        setupTextField()
//        setupConstraints()
//        setupPicker()
//    }
//
    @objc func done() {
        view.endEditing(true)
    }
//
//    private func setupTextField() {
//        textField = UITextField(frame: .zero)
//        textField.borderStyle = .roundedRect
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(textField)
//    }
//
//    private func setupConstraints() {
//        NSLayoutConstraint.activate([
//        textField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//        textField.centerYAnchor.constraint(equalTo:   self.view.centerYAnchor),
//        textField.heightAnchor.constraint(equalToConstant: 34),
//        textField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9)
//        ])
//    }
    
    private func setupPicker(){
        let pickerView = UIPickerView()
        pickerView.delegate = self
        textField.inputView = pickerView
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width:     UIScreen.main.bounds.width, height: 35))
    toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.done))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 0, inComponent: 0)
    }
    



}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 24
        case 1, 2:
            return 60
        default:
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.frame.size.width/3
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch component {
        case 0:
            currentTime.hours = pickerView.selectedRow(inComponent: 0)
            return "\(row) Hour"
        case 1:
            currentTime.minutes = pickerView.selectedRow(inComponent: 1)
            return "\(row) Minute"
        case 2:
            currentTime.seconds = pickerView.selectedRow(inComponent: 2)
            return "\(row) Second"
        default:
            return ""
       }

    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            currentTime.hours = row
        case 1:
            currentTime.minutes = row
        case 2:
            currentTime.seconds = row
        default:
            break;
         }
    }
}
