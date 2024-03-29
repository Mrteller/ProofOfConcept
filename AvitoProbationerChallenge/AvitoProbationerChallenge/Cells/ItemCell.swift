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
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var createdDateLbl: UILabel!
    @IBOutlet weak var checkmark: UIImageView!
    
    private var imageURL: URL? // var to keep track of currently loading image

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
        priceLbl.text = "\(object.item.price)"
        locationLbl.text = "\(object.item.location)"
        createdDateLbl.text = object.item.createdDate
        // TODO: Add label for `object.item.description`
        checkmark.isHidden = !object.isSelected
        // TODO: Refactor to async and remove code duplication with `UserItemCell`
        guard let objectURL = URL(string: object.item.imageURL)/*,
                objectURL != imageURL*/ else { return }
//        coverImg.image = nil // clear picture before fetching
//        imageURL = objectURL
//        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
//            guard let self,
//                  let imageData = try? Data(contentsOf: objectURL, options: .mappedIfSafe),
//                    self.imageURL == objectURL else { return }
//            DispatchQueue.main.async {
//                self.coverImg.image = UIImage(data: imageData)
//            }
//        }
        ImageCache.publicCache.load(url: objectURL as NSURL, item: object.item) { (fetchedItem, image) in
            if let image {
                self.coverImg.image = image
            }
        }
    }
}
