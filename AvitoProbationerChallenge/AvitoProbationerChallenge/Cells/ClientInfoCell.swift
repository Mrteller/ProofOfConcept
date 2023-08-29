//
//  ClientInfoCell.swift
//  AvitoProbationerChallenge
//
//  Created by Paul on 29/08/2023.
//

import UIKit

class ClientInfoCell: UICollectionViewCell, Cell {
    @IBOutlet weak var heyLbl: UILabel!
    @IBOutlet weak var booksInfoLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with object: ClientInfo) {
        heyLbl.text = "Hey \(object.clientName)!"
        switch object.booksAmount {
        case 0:
            booksInfoLbl.text = "You have \(object.booksAmount) books from \(object.maxBooksAmount), time to find your best book!"
        case 1..<object.maxBooksAmount:
            booksInfoLbl.text = "You have \(object.booksAmount) books from \(object.maxBooksAmount), don't forget to return them on time!"
        case object.maxBooksAmount:
            booksInfoLbl.text = "You can't take more books, try to return at least one book"
        default:
            ()
        }
    }
}
