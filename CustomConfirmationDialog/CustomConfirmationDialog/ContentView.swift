//
//  ContentView.swift
//  CustomConfirmationDialog
//
//  Created by Paul on 16.09.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showConfirmationDialog = false
    @State private var showModifierDialog = false
    
    var body: some View {
        VStack {
            Button("Show Dialog") { showConfirmationDialog = true }
            Button("Show ViewMod Dialog") {
                withAnimation {
                    showModifierDialog = true
                }
            }
            .padding()
        }
        .padding()
        
        // standard confirmationDialog
        .confirmationDialog("Test", isPresented: $showConfirmationDialog) {
            Button { } label: {
                Label("Add completion", systemImage: "checkmark.circle")
            }
            Button { } label: {
                Label("Add Note", systemImage: "note.text.badge.plus")
            }
            Button("Cancel", role: .cancel) {}
        }
        
        // custom confirmationDialog with Icons, Cancel added automatically
        .customConfirmDialog(isPresented: $showModifierDialog) {
            Button {
                // action
                showModifierDialog = false
            } label: {
                Label("Add completion", systemImage: "checkmark.circle")
            }
            Divider() // unfortunately this is still necessary
            Button {
                // action
                showModifierDialog = false
            } label: {
                Label("Add Note", systemImage: "note.text.badge.plus")
            }
        }
    }
}


// *** Custom ConfirmDialog Modifier and View extension

extension View {
    func customConfirmDialog<A: View>(isPresented: Binding<Bool>, @ViewBuilder actions: @escaping () -> A) -> some View {
        return self.modifier(MyCustomModifier(isPresented: isPresented, actions: actions))
    }
}

struct MyCustomModifier<A>: ViewModifier where A: View {
    
    @Binding var isPresented: Bool
    @ViewBuilder let actions: () -> A
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            ZStack(alignment: .bottom) {
                if isPresented {
                    Color.primary.opacity(0.2)
                        .ignoresSafeArea()
                        .onTapGesture {
                            isPresented = false
                        }
                        .transition(.opacity)
                }
                
                if isPresented {
                    VStack {
                        GroupBox {
                            actions()
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        GroupBox {
                            Button("Cancel", role: .cancel) {
                                isPresented = false
                            }
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                    .font(.title3)
                    .padding(8)
                    .transition(.move(edge: .bottom))
                }
            }
        }
        .animation(.easeInOut, value: isPresented)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
