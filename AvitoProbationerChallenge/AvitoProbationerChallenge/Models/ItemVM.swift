//
//  ItemVM.swift
//  AvitoProbationerChallenge
//
//  Created by Paul on 29/08/2023.
//

import UIKit

struct ItemVM<T: Hashable> {
    let item: T
    var isSelected: Bool = false

}

extension ItemVM: Equatable where T: Identifiable {
    var id: T.ID {
        item.id
    }
}

extension ItemVM: Hashable where T: Identifiable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(isSelected)
    }
}
