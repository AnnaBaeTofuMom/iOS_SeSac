//
//  SearchTableViewCell.swift
//  SeSAC_WEEK6
//
//  Created by 배경원 on 2021/11/01.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet var searchDetailLabel: UILabel!
    @IBOutlet var searchDateLabel: UILabel!
    @IBOutlet var searchTitleLabel: UILabel!
    @IBOutlet var searchImageView: UIImageView!
    
    func configureCell(row: UserDiary) {
        searchTitleLabel.text = row.diaryTitle
        searchDetailLabel.text = row.content
        searchDateLabel.text = "\(row.regDate)"
    
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
