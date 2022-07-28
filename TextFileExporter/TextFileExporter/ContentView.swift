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
    @State private var isShowingShareSheet = false
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

            Button {
                let url = getDocumentsDirectory().appendingPathComponent("hardcoded.txt")
                do {
                    try textToSave.write(to: url, atomically: true, encoding: .utf8)
                    let input = try String(contentsOf: url)
                    print(input)
                } catch {
                    print(error.localizedDescription)
                }
            } label: {
                Label("Export to documentDirectory", systemImage: "square.and.arrow.down")
            }
            
            Button {
                isShowingShareSheet = true
            } label: {
                Label("Share", systemImage: "square.and.arrow.down")
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
        .sheet(isPresented: $isShowingShareSheet) {
            ShareSheet(activityItems: [textToSave])
        }
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
