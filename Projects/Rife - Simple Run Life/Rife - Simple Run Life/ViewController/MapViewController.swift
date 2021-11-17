//
//  MapViewController.swift
//  Rife - Simple Run Life
//
//  Created by 배경원 on 2021/11/17.
//

import UIKit
import SideMenu
import MarqueeLabel
import XCTest

class MapViewController: UIViewController {
    
    
    var runMode:RunMode = .ready
    
    @IBOutlet var resultDistanceLabel: UILabel!
    @IBOutlet var resultTimeLabel: UILabel!
    @IBOutlet var runButton: UIButton!
    @IBOutlet var navigationBar: UIView!
    
    func outline(string:String, font:String, size:CGFloat, outlineSize:Float, textColor:UIColor, outlineColor:UIColor) -> NSMutableAttributedString {
        return NSMutableAttributedString(string:string,
                                         attributes: outlineAttributes(font: UIFont(name: font, size: size)!,
                                                            outlineSize: outlineSize, textColor: textColor, outlineColor: outlineColor))
    }

    func outlineAttributes(font: UIFont, outlineSize: Float, textColor: UIColor, outlineColor: UIColor) -> [NSAttributedString.Key: Any]{
        return [
            NSAttributedString.Key.strokeColor : outlineColor,
            NSAttributedString.Key.foregroundColor : textColor,
            NSAttributedString.Key.strokeWidth : -outlineSize,
            NSAttributedString.Key.font : font
        ]
    }
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationBar.layer.borderWidth = 1
        navigationBar.layer.borderColor = UIColor(named: "black")?.cgColor
        
        resultDistanceLabel.attributedText = outline(string: "11.25km", font: "NotoSansKR-Black", size: 40, outlineSize: 3, textColor: UIColor(red: 0.4941, green: 0.9922, blue: 0.6941, alpha: 1.0), outlineColor: .black)
        resultTimeLabel.attributedText = outline(string: "1:00:25", font: "NotoSansKR-Black", size: 40, outlineSize: 3, textColor: UIColor(red: 0.4941, green: 0.9922, blue: 0.6941, alpha: 1.0), outlineColor: .black)
        
        resultDistanceLabel.isHidden = true
        resultTimeLabel.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("mapView appear")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func sideBarButtonClicked(_ sender: UIButton) {
        
        
    }
    
    @IBAction func runButtonClicked(_ sender: UIButton) {
        if runMode == .ready {
            runButton.setImage(UIImage(named: "Stop"), for: .normal)
            self.runMode = .running
            resultDistanceLabel.isHidden = true
            resultTimeLabel.isHidden = true
        } else if runMode == .running {
            runButton.setImage(UIImage(named: "Save"), for: .normal)
            self.runMode = .finished
            resultDistanceLabel.isHidden = false
            resultTimeLabel.isHidden = false
        } else if runMode == .finished {
            runButton.setImage(UIImage(named: "Start"), for: .normal)
            self.runMode = .ready
            resultDistanceLabel.isHidden = true
            resultTimeLabel.isHidden = true
        } else {
            
        }
    }

}
