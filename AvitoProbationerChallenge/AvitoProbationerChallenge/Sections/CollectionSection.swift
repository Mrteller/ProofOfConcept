//
//  CollectionSection.swift
//  AvitoProbationerChallenge
//
//  Created by Paul on 29/08/2023.
//

import UIKit

class CollectionSection<T: Hashable, CollectionCell: Cell>: Section
where CollectionCell: UICollectionViewCell, CollectionCell.Object == T {
    var layout: ((NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection)?
    var cellConfiguration: ((CollectionCell) -> Void)?
    var cellSelection: ((T, Int) -> Void)?

    private var cellId: String {
        return String(describing: CollectionCell.self)
    }

    override func registerCells(in collection: UICollectionView) {
        collection.register(UINib(nibName: cellId, bundle: nil),
                            forCellWithReuseIdentifier: cellId)
    }

    override func cell(for item: AnyHashable, at indexPath: IndexPath, in collection: UICollectionView) -> UICollectionViewCell? {
        guard let item = item as? T else { return nil }

        guard let cell = collection.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? CollectionCell else { return nil }
        cell.prepareForReuse()
        cell.configure(with: item)
        cellConfiguration?(cell)

        return cell
    }

    override func didSelect(item: AnyHashable, at index: Int) {
        guard let item = item as? T else { return }

        cellSelection?(item, index)
    }

    override func layout(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        return layout?(environment)
    }
}
