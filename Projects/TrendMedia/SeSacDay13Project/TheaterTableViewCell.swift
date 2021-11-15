//
//  TheaterTableViewCell.swift
//  SeSacDay13Project
//
//  Created by 경원이 on 2021/10/24.
//

import UIKit

class TheaterTableViewCell: UITableViewCell {
    
    var identifier = "TheaterTableViewCell"
    
    
    @IBOutlet var theaterNameLabel: UILabel!
    
    @IBOutlet var theaterAddressLabel: UILabel!
    @IBOutlet var viewMapButton: UIButton!
    
    @IBOutlet var contactNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func viewMapButtonClicked(_ sender: Any) {
        print("클릭됨")
        
    
    }
}
