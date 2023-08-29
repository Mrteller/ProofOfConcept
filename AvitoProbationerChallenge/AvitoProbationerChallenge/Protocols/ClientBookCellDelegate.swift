//
//  ClientBookCellDelegate.swift
//  AvitoProbationerChallenge
//
//  Created by Paul on 29/08/2023.
//

import Foundation

protocol ClientBookCellDelegate: AnyObject {
    func didTapReturn(book: ClientItem)
}
