//
//  ContentView.swift
//  TextFileExporter
//
//  Created by Paul on 28.07.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingExporter = false
    @State private var textToSave = ""
    var body: some View {
        VStack {
            Text("Save txt example")
                .padding()
            TextField("Text to save", text: $textToSave)
            Button {
                isShowingExporter = true
            } label: {
                Label("Export", systemImage: "square.and.arrow.down")
            }

        }
        .fileExporter(isPresented: $isShowingExporter, document: TextFile(initialText: textToSave), contentType: .plainText, defaultFilename: "Test") { result in
            switch result {
            case .success(let url):
                print("Saved to \(url)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
