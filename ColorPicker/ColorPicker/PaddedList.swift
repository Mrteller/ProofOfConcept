//
//  PaddedList.swift
//  ColorPicker
//
//  Created by Paul on 29.05.2022.
//

import SwiftUI

enum Kind: String, CaseIterable {
    case checking
    case savings
    case investment
}

struct PaddedList: View {
    @Binding var name: String
    @Binding var kind: Kind
    
    var body: some View {
        NavigationView {
            List {
                TextField("Account name", text: $name)
                Picker("Kind", selection: $kind) {
                    ForEach(Kind.allCases, id: \.self) { kind in
                        Text(kind.rawValue).tag(kind)
                    }
                }
                .listRowSeparatorTint(.red)
                Spacer()
            }
            .padding(.top, 1) // note top 1 padding!
            .background(.green) // the color "bleeds" through
            .navigationBarTitle("Navigation Bar")
        }
    }
}

struct PaddedList_Previews: PreviewProvider {
    static var previews: some View {
        PaddedList(name: .constant(""), kind: .constant(.checking))
    }
}
