//
//  HomeTableViewCell.swift
//  SeSAC_WEEK6
//
//  Created by 경원이 on 2021/11/08.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    static let identifier = "HomeTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        collectionView.dataSource = self
   //     collectionView.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
