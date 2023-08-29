//
//  ViewController.swift
//  AvitoProbationerChallenge
//
//  Created by Paul on 29/08/2023.
//

import UIKit

final class ViewController: UIViewController {
    
    enum CollectionSections: String {
        case clientSection
        case clientBookSection
        case bookSection
    }
    
    @IBOutlet weak var collection: UICollectionView!
    lazy var adapter = CollectionAdapter(collection: self.collection, delegate: self)
    
    var clientInfo = ClientInfo(id: UUID().uuidString,
                                clientName: "John Doe",
                                maxBooksAmount: 5,
                                booksAmount: 0)
    var clientBooks: [ClientItem] = []
    var books = Item.fakeItems
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Library"
        
        adapter.performUpdates(animated: false)
    }
}

extension ViewController: CollectionAdapterDelegate {
    func sections() -> [Section] {
        let clientSection = CollectionSection<ClientInfo, ClientInfoCell>(id: CollectionSections.clientSection.rawValue)
        clientSection.layout = { env in
            return NSCollectionLayoutSection.listLayout(environment: env, height: .estimated(90))
        }
        
        let clientBookSection = ClientBooksSection(id: CollectionSections.clientBookSection.rawValue)
        clientBookSection.cellConfiguration = { cell in
            cell.delegate = self
        }
        
        let booksSection = CollectionSection<Item, BookCell>(id: CollectionSections.bookSection.rawValue)
        booksSection.layout = { env in
            return NSCollectionLayoutSection.gridLayout(environment: env, height: .estimated(300), compactItems: 2, regularItems: 4)
        }
        booksSection.cellSelection = { [weak self] book, index in
            self?.didSelect(book: book, at: index)
        }
        
        return [clientSection, clientBookSection, booksSection]
    }
    
    func itemsFor(section: Section) -> [AnyHashable] {
        switch section {
        case is CollectionSection<ClientInfo, ClientInfoCell>:
            return [clientInfo]
        case is ClientBooksSection:
            return clientBooks
        case is CollectionSection<Item, BookCell>:
            return books
        default:
            return []
        }
    }
    
    func didSelect(book: Item, at index: Int) {
        books[index].isSelected.toggle()
        let book = books[index]
        if book.isSelected && clientInfo.booksAmount != clientInfo.maxBooksAmount {
            clientInfo.booksAmount += 1
            clientBooks.append(ClientItem(book: book))
        } else if !book.isSelected, let clientBookIndex = clientBooks.firstIndex(where: { $0.id == book.id }) {
            clientInfo.booksAmount -= 1
            clientBooks.remove(at: clientBookIndex)
        }
        adapter.performUpdates(animated: true)
    }
}

extension ViewController: ClientBookCellDelegate {
    func didTapReturn(book: ClientItem) {
        guard let index = clientBooks.firstIndex(of: book) else {
            return
        }
        clientInfo.booksAmount -= 1
        clientBooks.remove(at: index)
        if let bookIndex = books.firstIndex(where: { $0.id == book.id }) {
            books[bookIndex].isSelected.toggle()
        }
        adapter.performUpdates(animated: true)
    }
}

