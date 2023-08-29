//
//  ItemCell.swift
//  AvitoProbationerChallenge
//
//  Created by Paul on 29/08/2023.
//

import UIKit

class ItemCell: UICollectionViewCell, Cell {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var coverImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var pagesLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var checkmark: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        shadowView.layer.cornerRadius = 10
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowColor = UIColor.lightGray.cgColor
        shadowView.layer.shadowOpacity = 0.2
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowView.layer.shadowRadius = 6
    }
    
    func configure(with object: ItemVM<Item>) {
        nameLbl.text = object.item.title
        yearLbl.text = "\(object.item.price)"
        pagesLbl.text = "\(object.item.location)"
        descriptionLbl.text = object.item.description
        checkmark.isHidden = !object.isSelected
        // TODO: Refactor to async
        guard let imageURL = URL(string: object.item.imageURL),
        let imageData = try? Data(contentsOf: imageURL, options: .alwaysMapped) else { return }
        coverImg.image = UIImage(data: imageData)
    }
}
