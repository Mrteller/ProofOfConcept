import SwiftUI

enum SomeEnum: String, CaseIterable, CustomStringConvertible, Identifiable {
    case one, two, three
    var description: String {
        switch self {
        case .one:
            return NSLocalizedString("One", comment: "SomeEnum in \(#file)")
        case .two:
            return NSLocalizedString("Two", comment: "SomeEnum in \(#file)")
        case .three:
            return NSLocalizedString("Three", comment: "SomeEnum in \(#file)")
        }
    }
    var id: Self { self }
}


struct SegmentedPickerInsideForm: View {
    @State private var someText = ""
    @State private var pickerSelection: SomeEnum = .one
    @FocusState private var isTaxRateFieldIsFocused: Bool
    let tapToHideKeyboard = TapGesture().onEnded {
        print("Tap on Form")
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    var body: some View {
        Form {
            Section("Text") {
                TextField("", text: $someText) // Responds to taps
                HStack {
                    Text(pickerSelection.description)
                        .frame(minWidth: 400)
                }
            }
            
            Section("Picker") {
                Picker("Tax", selection: $pickerSelection) { // Doesn't respond to taps!
                    ForEach(SomeEnum.allCases) { someCase in
                        Text(someCase.description).tag(someCase.rawValue)
                    }
                }
                .pickerStyle(.segmented) // Doesn't respond to taps for `.segmented` style only!
            }
            
            Section("Button") {
                Button("Tap me") { // Doesn't respond to taps!
                    print("Tap on a Button")
                }
            }
        }
        .gesture(tapToHideKeyboard)
        
    }
}
