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

    weak var delegate: UserItemCellDelegate?
    
    private var item: Item?
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

    @IBAction func returnItem(_ sender: Any) {
        guard let item else { return }
        delegate?.didTapMark(item: item)
    }

    func configure(with object: Item) {
        self.item = object
        
        itemNameLbl.text = object.title
        yearLbl.text = "\(object.price)"
        pagesLbl.text = "\(object.location)"
//        guard let imageURL = URL(string: object.imageURL),
//              let imageData = try? Data(contentsOf: imageURL, options: .alwaysMapped) else { return }
//        coverImg.image = UIImage(data: imageData)
        // TODO: Refactor to async and remove code duplication with `ItemCell`.
        guard let objectURL = URL(string: object.imageURL),
              objectURL != imageURL else { return }
        coverImg.image = nil // clear picture before fetching
        imageURL = objectURL
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self,
                  let imageData = try? Data(contentsOf: objectURL, options: .mappedIfSafe),
                  self.imageURL == objectURL else { return }
            DispatchQueue.main.async {
                self.coverImg.image = UIImage(data: imageData)
            }
        }
    }
}
