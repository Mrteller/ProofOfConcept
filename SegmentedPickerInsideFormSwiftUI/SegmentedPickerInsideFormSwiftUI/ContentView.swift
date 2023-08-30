//
//  ContentView.swift
//  SegmentedPickerInsideFormSwiftUI
//
//  Created by Paul on 30/08/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var someText = ""
    @State private var taxPersent = 10.0
    @State private var itemTaxPersent = 10.0
    @FocusState private var isTaxRateFieldIsFocused: Bool
    let newGesture = TapGesture().onEnded {
        print("Tap on Form")
    }
    
    var body: some View {
        Form {
            Section(header: Text("header")) {
                TextField("", text: $someText)
                    .focused($isTaxRateFieldIsFocused)
                HStack {
                    Text(TaxRate(rawValue: taxPersent)?.description ?? "Unknown tax")
                    Text("\(itemTaxPersent)")
                }
            }
            
            Picker("Tax", selection: $taxPersent) {
                ForEach(TaxRate.allCases) { tax in
                    Text(tax.description).tag(tax.rawValue)
                }
            }
            .pickerStyle(.segmented)
            .onChange(of: taxPersent) { newTax in
                isTaxRateFieldIsFocused = false
                itemTaxPersent = newTax
            }
            
            
            Button("Button") {
                print("Tap on a Button")
            }
        }
        //.formStyle(.columns)
        .gesture(newGesture)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
