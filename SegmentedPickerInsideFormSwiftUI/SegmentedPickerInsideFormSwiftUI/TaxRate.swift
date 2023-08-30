//
//  TaxRate.swift
//  SegmentedPickerInsideFormSwiftUI
//
//  Created by Paul on 30/08/2023.
//

import Foundation

enum TaxRate: Double, CaseIterable, CustomStringConvertible, Codable, Identifiable {
    case ndsFoodLight = 10.1, ndsFood = 20.0
    var description: String {
        switch self {
        case .ndsFoodLight:
            return NSLocalizedString("Tax Food Light", comment: "")
        case .ndsFood:
            return NSLocalizedString("Tax Food", comment: "")
        }
    }
    var id: Self { self }
}
