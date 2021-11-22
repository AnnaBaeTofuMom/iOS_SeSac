//
//  RecordDetailViewController.swift
//  Rife - Simple Run Life
//
//  Created by 배경원 on 2021/11/22.
//

import UIKit
import MapKit

class RecordDetailViewController: UIViewController {
        
    @IBOutlet var distanceLabel: UILabel!
    var recordData: RecordObject!
    
    @IBOutlet var memoTextView: UITextView!
    @IBOutlet var mapImageView: UIImageView!
    @IBOutlet var timeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let distanceformatter = MKDistanceFormatter()
        distanceformatter.units = .metric
        let stringDistance = distanceformatter.string(fromDistance: recordData.distance)
        
        distanceLabel.text = "\(stringDistance)"
        timeLabel.text = "\(recordData.time)"
        memoTextView.text = ""
        mapImageView.image = UIImage(data: recordData.image)
        
        
        
        
        
       
        
        
    }
    

  
    @IBAction func backButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
