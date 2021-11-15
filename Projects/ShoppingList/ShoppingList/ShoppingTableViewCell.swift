//
//  ShoppingTableViewCell.swift
//  ShoppingList
//
//  Created by 배경원 on 2021/11/03.
//

import UIKit

class ShoppingTableViewCell: UITableViewCell {

    @IBOutlet var heartButton: UIButton!
    @IBOutlet var checkBoxButton: UIButton!
    @IBOutlet var shoppingLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
