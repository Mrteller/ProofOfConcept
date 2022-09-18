//
//  ContentView.swift
//  ScrollToListItem
//
//  Created by Paul on 16.09.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedIndex: Int = 0
    
    var body: some View {
        VStack {
            NavigationView {
                ScrollViewReader { scrollView in
                    List {
                        ForEach(0..<100, id:\.self) { index in
                            Text("Row number \(index)").id(index)
                                .padding()
                        }
                    }
                    
                    Divider()
                    
                    Picker("", selection: $selectedIndex) {
                        ForEach(0..<100, id: \.self) { index in
                            Text("Go to Row \(index)")
                        }
                        .onChange(of: selectedIndex) {value in
                            withAnimation {
                                scrollView.scrollTo(
                                    selectedIndex, anchor: .center
                                )
                            }
                        }
                    }
                    .pickerStyle(.wheel)
                }
                .navigationTitle("Scroll To Demo")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
