//
//  Section.swift
//  AvitoProbationerChallenge
//
//  Created by Paul on 29/08/2023.
//

import UIKit

class Section {
    let id: String
    var isEmpty: Bool = true

    init(id: String) {
        self.id = id
    }

    func registerCells(in collection: UICollectionView) {

    }

    func cell(for item: AnyHashable, at indexPath: IndexPath, in collection: UICollectionView) -> UICollectionViewCell? {
        return nil
    }

    func didSelect(item: AnyHashable, at index: Int) {
        
    }

    func supplementaryView(kind: String, for item: AnyHashable?, at indexPath: IndexPath, in collection: UICollectionView) -> UICollectionReusableView? {
        return nil
    }

    func layout(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        return nil
    }

}

extension Section: Equatable {
    static func == (lhs: Section, rhs: Section) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Section: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
