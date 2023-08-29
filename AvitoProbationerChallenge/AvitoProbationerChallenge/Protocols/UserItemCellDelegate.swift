//
//  UserItemCellDelegate.swift
//  AvitoProbationerChallenge
//
//  Created by Paul on 29/08/2023.
//

import Foundation

protocol UserItemCellDelegate: AnyObject {
    func didTapMark(item: Item)
}
