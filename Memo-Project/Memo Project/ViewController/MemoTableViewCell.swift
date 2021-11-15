//
//  MemoTableViewCell.swift
//  Memo Project
//
//  Created by 배경원 on 2021/11/08.
//

import UIKit

class MemoTableViewCell: UITableViewCell {
    static let identifier = "MemoListCell"
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    
    @IBOutlet var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
