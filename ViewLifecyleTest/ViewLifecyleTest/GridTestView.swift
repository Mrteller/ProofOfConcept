//
//  GridTestView.swift
//  ViewLifecyleTest
//
//  Created by Paul on 07/10/2023.
//
// For SO: https://stackoverflow.com/questions/62800463/correct-way-to-layout-swiftui-similar-to-autolayout/77249313

import SwiftUI

struct GridTextView: View {
        var rowData: [RowData] = RowData.sample
        var body: some View {
            Grid(alignment: .leading) {
                Text("Some sort of title")
                ForEach(RowData.sample) { row in
                    GridRow {
                        Text(row.id)
                        Text(row.name)
                            .gridCellColumns(2)
                    }
                }
                GridRow {
                    let row = RowData.sample.first!
                    Text(row.id)
                    Text(row.name)
                    Text("Third extra column")
                }
            }
            .padding()
        }
    }
    
    struct RowData: Identifiable {
        var id: String
        var name: String
        static var sample: [Self] = [.init(id: "1", name: "Joe Doe"), .init(id: "10000", name: "Diana Snow")]
    }

#Preview {
    GridTextView()
}
