//
//  UserItemCell.swift
//  AvitoProbationerChallenge
//
//  Created by Paul on 29/08/2023.
//

import UIKit

class UserItemCell: UICollectionViewCell, Cell {

    @IBOutlet weak var itemNameLbl: UILabel!
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var pagesLbl: UILabel!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var coverImg: UIImageView!

    private var item: Item?
    weak var delegate: UserItemCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

        shadowView.layer.cornerRadius = 10
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowColor = UIColor.lightGray.cgColor
        shadowView.layer.shadowOpacity = 0.2
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowView.layer.shadowRadius = 6
    }

    @IBAction func returnItem(_ sender: Any) {
        guard let item else { return }
        delegate?.didTapMark(item: item)
    }

    func configure(with object: Item) {
        self.item = object
        
        itemNameLbl.text = object.title
        yearLbl.text = "\(object.price)"
        pagesLbl.text = "\(object.location)"
        guard let imageURL = URL(string: object.imageURL),
              let imageData = try? Data(contentsOf: imageURL, options: .alwaysMapped) else { return }
        coverImg.image = UIImage(data: imageData)
    }
}
