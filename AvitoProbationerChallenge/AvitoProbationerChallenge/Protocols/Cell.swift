//
//  Cell.swift
//  AvitoProbationerChallenge
//
//  Created by Paul on 29/08/2023.
//

import Foundation

protocol Cell {
    associatedtype Object

    func configure(with object: Object)
}
