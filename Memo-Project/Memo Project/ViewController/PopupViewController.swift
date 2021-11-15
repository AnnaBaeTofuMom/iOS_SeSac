//
//  PopupViewController.swift
//  Memo Project
//
//  Created by 경원이 on 2021/11/12.
//

import UIKit

class PopupViewController: UIViewController {

    @IBOutlet var okBtn: UIButton!
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var uiView: UIView!
    @IBOutlet var subLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("popup is loaded")
        uiView.layer.cornerRadius = 10
        
    }
    

    @IBAction func okBtnClicked(_ sender: UIButton) {
        print(#function)
        self.dismiss(animated: true, completion: nil)
    }
    
}
