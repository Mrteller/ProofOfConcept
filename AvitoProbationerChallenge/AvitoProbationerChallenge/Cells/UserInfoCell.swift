//
//  UserInfoCell.swift
//  AvitoProbationerChallenge
//
//  Created by Paul on 29/08/2023.
//

import UIKit

class UserInfoCell: UICollectionViewCell, Cell {
    @IBOutlet weak var greetLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!

    func configure(with object: UserInfo) {
        greetLabel.text = NSLocalizedString("Hello \(object.userName)!", comment: "Greeting label in a cell")
        switch object.itemsAmount {
        case 0:
            infoLabel.text = "You have \(object.itemsAmount) items from \(object.maxItemsAmount), time to find your best item!"
        case 1..<object.maxItemsAmount:
            infoLabel.text = "You have \(object.itemsAmount) items from \(object.maxItemsAmount), don't forget to return them on time!"
        case object.maxItemsAmount:
            infoLabel.text = "You can't take more items, try to return at least one item"
        default:
            ()
        }
    }
}
