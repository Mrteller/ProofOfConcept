//
//  UserItemsSection.swift
//  AvitoProbationerChallenge
//
//  Created by Paul on 29/08/2023.
//

import UIKit

final class UserItemsSection: CollectionSection<Item, UserItemCell> {

    static private let emptyViewKind = "EmptyUserItemSectionView"

    private var emptyView: EmptyUserItemSectionView?
    override var isEmpty: Bool {
        didSet {
            emptyView?.contentView.isHidden = !isEmpty
        }
    }

    override func registerCells(in collection: UICollectionView) {
        super.registerCells(in: collection)
        collection.register(UINib(nibName: UserItemsSection.emptyViewKind, bundle: nil),
                            forSupplementaryViewOfKind: UserItemsSection.emptyViewKind,
                            withReuseIdentifier: UserItemsSection.emptyViewKind)
    }

    override func layout(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6),
                                               heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])

        let emptyViewSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(150.0))

        let left = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: emptyViewSize,
                                                               elementKind: UserItemsSection.emptyViewKind,
                                                               alignment: .leading)

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [left]
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        return section
    }

    override func supplementaryView(kind: String, for item: AnyHashable?, at indexPath: IndexPath, in collection: UICollectionView) -> UICollectionReusableView? {
        guard let emptyView = collection.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: UserItemsSection.emptyViewKind,
            for: indexPath) as? EmptyUserItemSectionView else {
                return nil
        }
        self.emptyView = emptyView
        emptyView.isHidden = !isEmpty

        return emptyView
    }
}
