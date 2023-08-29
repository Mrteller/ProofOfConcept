//
//  ItemsListViewController.swift
//  AvitoProbationerChallenge
//
//  Created by Paul on 29/08/2023.
//

import UIKit

final class ItemsListViewController: UIViewController {
    
    enum CollectionSections: String {
        case userSection
        case userItemSection
        case itemSection
    }
    
    @IBOutlet weak var collection: UICollectionView!
    lazy var adapter = CollectionAdapter(collection: self.collection, delegate: self)
    
    var userInfo = UserInfo(id: UUID().uuidString,
                                userName: "John Doe",
                                maxItemsAmount: 5,
                                itemsAmount: 0)
    var selectedItems: [UserItem] = []
    var items = Item.fakeItems
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Library"
        
        adapter.performUpdates(animated: false)
    }
}

extension ItemsListViewController: CollectionAdapterDelegate {
    func sections() -> [Section] {
        let userSection = CollectionSection<UserInfo, UserInfoCell>(id: CollectionSections.userSection.rawValue)
        userSection.layout = { env in
            return NSCollectionLayoutSection.listLayout(environment: env, height: .estimated(90))
        }
        
        let userItemSection = UserItemsSection(id: CollectionSections.userItemSection.rawValue)
        userItemSection.cellConfiguration = { cell in
            cell.delegate = self
        }
        
        let itemsSection = CollectionSection<Item, ItemCell>(id: CollectionSections.itemSection.rawValue)
        itemsSection.layout = { env in
            return NSCollectionLayoutSection.gridLayout(environment: env, height: .estimated(300), compactItems: 2, regularItems: 4)
        }
        itemsSection.cellSelection = { [weak self] item, index in
            self?.didSelect(item: item, at: index)
        }
        
        return [userSection, userItemSection, itemsSection]
    }
    
    func itemsFor(section: Section) -> [AnyHashable] {
        switch section {
        case is CollectionSection<UserInfo, UserInfoCell>:
            return [userInfo]
        case is UserItemsSection:
            return selectedItems
        case is CollectionSection<Item, ItemCell>:
            return items
        default:
            return []
        }
    }
    
    func didSelect(item: Item, at index: Int) {
        items[index].isSelected.toggle()
        let item = items[index]
        if item.isSelected && userInfo.itemsAmount != userInfo.maxItemsAmount {
            userInfo.itemsAmount += 1
            selectedItems.append(UserItem(item: item))
        } else if !item.isSelected, let userItemIndex = selectedItems.firstIndex(where: { $0.id == item.id }) {
            userInfo.itemsAmount -= 1
            selectedItems.remove(at: userItemIndex)
        }
        adapter.performUpdates(animated: true)
    }
}

extension ItemsListViewController: UserItemCellDelegate {
    func didTapMark(item: UserItem) {
        guard let index = selectedItems.firstIndex(of: item) else {
            return
        }
        userInfo.itemsAmount -= 1
        selectedItems.remove(at: index)
        if let itemIndex = items.firstIndex(where: { $0.id == item.id }) {
            items[itemIndex].isSelected.toggle()
        }
        adapter.performUpdates(animated: true)
    }
}

