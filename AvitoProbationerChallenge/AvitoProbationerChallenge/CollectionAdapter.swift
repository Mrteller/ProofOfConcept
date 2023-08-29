//
//  CollectionAdapter.swift
//  AvitoProbationerChallenge
//
//  Created by Paul on 29/08/2023.
//

import UIKit

final class CollectionAdapter: NSObject {
    private weak var collection: UICollectionView?
    private lazy var datasource: UICollectionViewDiffableDataSource<Section, AnyHashable> = UICollectionViewDiffableDataSource(collectionView: self.collection!, cellProvider: cell)
    private weak var delegate: CollectionAdapterDelegate?

    init(collection: UICollectionView, delegate: CollectionAdapterDelegate) {
        self.collection = collection
        self.delegate = delegate
        super.init()
        for section in delegate.sections() {
            section.registerCells(in: collection)
        }
        collection.collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: sectionLayout)
        collection.delegate = self
        datasource.supplementaryViewProvider = supplementaryView
    }

    private func cell(in collection: UICollectionView, at indexPath: IndexPath, for item: AnyHashable) -> UICollectionViewCell? {
        guard let item = datasource.itemIdentifier(for: indexPath),
              let section = datasource.sectionIdentifier(for: indexPath.section) else { return nil }
        
        return section.cell(for: item, at: indexPath, in: collection)
    }

    private func supplementaryView(in collection: UICollectionView, kind: String, at indexPath: IndexPath) -> UICollectionReusableView? {
        guard let section = datasource.sectionIdentifier(for: indexPath.section) else { return nil }
        return section.supplementaryView(kind: kind, for: datasource.itemIdentifier(for: indexPath), at: indexPath, in: collection)
    }

    private func sectionLayout(for sectionIndex: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        guard let section = datasource.sectionIdentifier(for: sectionIndex) else { return nil }
        //let section = datasource.snapshot().sectionIdentifiers[sectionIndex]
        return section.layout(environment: environment)
    }

    func performUpdates(animated: Bool, completion: (() -> Void)? = nil) {
        guard let delegate else { return }

        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        for section in delegate.sections() {
            // section.registerCells(in: collection)
            snapshot.appendSections([section])

            let items = delegate.itemsFor(section: section)
            section.isEmpty = items.count == 0
            snapshot.appendItems(items)
        }
        datasource.apply(snapshot, animatingDifferences: animated, completion: completion)
    }
}

extension CollectionAdapter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = datasource.itemIdentifier(for: indexPath),
        let section = datasource.sectionIdentifier(for: indexPath.section) else { return }
        section.didSelect(item: item, at: indexPath.row)
    }
}
