//
//  ClientBookCell.swift
//  AvitoProbationerChallenge
//
//  Created by Paul on 29/08/2023.
//

import UIKit

class ClientBookCell: UICollectionViewCell, Cell {

    @IBOutlet weak var bookNameLbl: UILabel!
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var pagesLbl: UILabel!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var coverImg: UIImageView!

    private var book: ClientItem?
    weak var delegate: ClientBookCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

        shadowView.layer.cornerRadius = 10
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowColor = UIColor.lightGray.cgColor
        shadowView.layer.shadowOpacity = 0.2
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowView.layer.shadowRadius = 6
    }

    @IBAction func returnBook(_ sender: Any) {
        guard let book = book else {
            return
        }
        delegate?.didTapReturn(book: book)
    }

    func configure(with object: ClientItem) {
        self.book = object
        
        bookNameLbl.text = object.name
        yearLbl.text = "\(object.year)"
        pagesLbl.text = "\(object.amountPages)"
        coverImg.image = object.cover
    }
}
