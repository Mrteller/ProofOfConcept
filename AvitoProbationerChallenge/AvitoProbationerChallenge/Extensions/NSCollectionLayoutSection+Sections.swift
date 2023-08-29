//
//  NSCollectionLayoutSection+Sections.swift
//  AvitoProbationerChallenge
//
//  Created by Paul on 29/08/2023.
//

import UIKit

extension NSCollectionLayoutSection {
    static func listLayout(environment: NSCollectionLayoutEnvironment, height: NSCollectionLayoutDimension) -> NSCollectionLayoutSection {
        let itemSize: NSCollectionLayoutSize
        if height.isEstimated {
            itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: height)
        } else {
            itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        }
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: height)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])

        return NSCollectionLayoutSection(group: group)
    }

    static func gridLayout(environment: NSCollectionLayoutEnvironment, height: NSCollectionLayoutDimension,
                           compactItems: Int, regularItems: Int) -> NSCollectionLayoutSection {
        let itemSize: NSCollectionLayoutSize
        let count: Int = environment.traitCollection.horizontalSizeClass == .compact ? compactItems : regularItems
        if height.isEstimated {
            itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0 / CGFloat(count)),
                                              heightDimension: height)
        } else {
            itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0 / CGFloat(count)),
                                              heightDimension: .fractionalHeight(1.0))
        }
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: height)

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitem: item, count: count)

        return NSCollectionLayoutSection(group: group)
    }
}
