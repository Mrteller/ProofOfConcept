//
//  ItemVM.swift
//  AvitoProbationerChallenge
//
//  Created by Paul on 29/08/2023.
//

import UIKit

struct ItemVM<T: Hashable>: Hashable where T: Identifiable {
    let item: T
    var isSelected: Bool = false
    var id: T.ID {
        item.id
    }
}
