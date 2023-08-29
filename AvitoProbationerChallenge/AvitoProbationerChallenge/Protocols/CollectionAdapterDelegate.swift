//
//  CollectionAdapterDelegate.swift
//  AvitoProbationerChallenge
//
//  Created by Paul on 29/08/2023.
//

import Foundation

protocol CollectionAdapterDelegate: AnyObject {
    func sections() -> [Section]
    func itemsFor(section: Section) -> [AnyHashable]
}
