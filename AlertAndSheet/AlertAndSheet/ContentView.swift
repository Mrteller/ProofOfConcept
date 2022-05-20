//
//  ContentView.swift
//  AlertAndSheet
//
//  Created by Paul on 11.05.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var sheet1 = false
    @State private var sheet2 = false
    @State private var alert1 = false
    @State private var alert2 = false
    var body: some View {
        VStack {
            Button("Sheet 1" ) {
                sheet1 = true
            }
            .padding()
            Button("Sheet 2") {
                sheet2 = true
            }
            .padding()
            Button("Alert 1") {
                alert1 = true
            }
            .padding()
            Button("Alert 2") {
                alert2 = true
            }
            .padding()
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity, maxHeight: . infinity, alignment: .center)
            .background (Color.green)
            //.blur(radius: redacted ? 10 : 0)
            //.redacted(reason: redacted ? .placeholder : [])
            //.onAppear (perform: configureView)
            .sheet(isPresented: $sheet1) {
                Text ("Sheet 1")
            }
            .sheet(isPresented: $sheet2) {
                Text("Sheet 2")
            }
            .alert("Alert 1", isPresented: $alert1) {
                Text("Alert 1")
            }
            .alert("Alert 2", isPresented: $alert2) {
                Text("Alert 2" )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
