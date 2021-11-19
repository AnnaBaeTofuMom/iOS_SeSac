//
//  RecordTableViewCell.swift
//  Rife - Simple Run Life
//
//  Created by 경원이 on 2021/11/18.
//

import UIKit

class RecordTableViewCell: UITableViewCell {

    @IBOutlet var recordImageView: UIImageView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var dateLabek: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
