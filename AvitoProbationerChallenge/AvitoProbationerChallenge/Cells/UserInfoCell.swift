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
        greetLabel.text = NSLocalizedString("Hello \(object.userName)!", comment: "Greeting label in a cell in \(#file)")
        switch object.itemsAmount {
            // TODO: Usen inflection [^] syntax to handle plurals properly
        case 0:
            infoLabel.text = NSLocalizedString("You have \(object.itemsAmount) items from \(object.maxItemsAmount)max!", comment: "Info label in a cell in \(#file)")
        case 1..<object.maxItemsAmount:
            infoLabel.text = NSLocalizedString("You have \(object.itemsAmount) items from \(object.maxItemsAmount)!", comment: "Info label in a cell in \(#file)")
        case object.maxItemsAmount:
            infoLabel.text = NSLocalizedString("You can't select more items, unselect at least one item", comment: "Info label in a cell in \(#file)")
        default:
            ()
        }
    }
}
