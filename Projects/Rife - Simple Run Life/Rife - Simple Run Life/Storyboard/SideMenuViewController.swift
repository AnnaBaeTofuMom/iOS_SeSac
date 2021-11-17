//
//  SideMenuViewController.swift
//  Rife - Simple Run Life
//
//  Created by 배경원 on 2021/11/17.
//

import UIKit

class SideMenuViewController: UIViewController {
    
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

    @IBOutlet var sideMenuView: UIView!
    @IBOutlet var myProfileButton: UIButton!
    @IBOutlet var contactButton: UIButton!
    @IBOutlet var settingsButton: UIButton!
    @IBOutlet var recordsButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuView.layer.borderColor = UIColor(named: "black")?.cgColor
        sideMenuView.layer.borderWidth = 1
        
        myProfileButton.titleLabel?.attributedText = outline(string: "MY PROFILE", font: "NotoSansKR-Black", size: 25, outlineSize: 4, textColor: .white, outlineColor: .black)
        recordsButton.titleLabel?.attributedText = outline(string: "RECORDS", font: "NotoSansKR-Black", size: 25, outlineSize: 4, textColor: .white, outlineColor: .black)
        settingsButton.titleLabel?.attributedText = outline(string: "SETTINGS", font: "NotoSansKR-Black", size: 25, outlineSize: 4, textColor: .white, outlineColor: .black)
        contactButton.titleLabel?.attributedText = outline(string: "CONTACT", font: "NotoSansKR-Black", size: 25, outlineSize: 4, textColor: .white, outlineColor: .black)
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
