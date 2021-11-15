//
//  MainTableViewCell.swift
//  SeSacDay13Project
//
//  Created by 경원이 on 2021/10/19.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet var cellContentView: UIView!
    override func awakeFromNib() {
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 16.0, left: 16, bottom: 16, right: 16))
        
        
        
    }

}
