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
    var selectedItems: [Item] = []
    var itemsVM = ItemsResponse.sample?.advertisements.compactMap{ ItemVM(item: $0) } ?? []
    
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
        
        let itemsSection = CollectionSection<ItemVM, ItemCell>(id: CollectionSections.itemSection.rawValue)
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
        case is CollectionSection<ItemVM<Item>, ItemCell>:
            return itemsVM
        default:
            return []
        }
    }
    
    func didSelect(item: ItemVM<Item>, at index: Int) {
        itemsVM[index].isSelected.toggle()
        let itemVM = itemsVM[index]
        if itemVM.isSelected && userInfo.itemsAmount != userInfo.maxItemsAmount {
            userInfo.itemsAmount += 1
            selectedItems.append(itemVM.item)
        } else if !itemVM.isSelected, let userItemIndex = selectedItems.firstIndex(where: { $0.id == itemVM.id }) {
            userInfo.itemsAmount -= 1
            selectedItems.remove(at: userItemIndex)
        }
        adapter.performUpdates(animated: true)
    }
}

extension ItemsListViewController: UserItemCellDelegate {
    func didTapMark(item: Item) {
        guard let index = selectedItems.firstIndex(of: item) else {
            return
        }
        userInfo.itemsAmount -= 1
        selectedItems.remove(at: index)
        if let itemIndex = itemsVM.firstIndex(where: { $0.id == item.id }) {
            itemsVM[itemIndex].isSelected.toggle()
        }
        adapter.performUpdates(animated: true)
    }
}

