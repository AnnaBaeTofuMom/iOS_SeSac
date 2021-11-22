//
//  SettingsViewController.swift
//  Rife - Simple Run Life
//
//  Created by 경원이 on 2021/11/18.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var contactButton: UIButton!
    @IBOutlet var openSourceButton: UIButton!
    @IBOutlet var restoreButton: UIButton!
    @IBOutlet var backupButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        let backupNSAS = outline(string: "BACK UP THIS APP", font: "NotoSansKR-Black", size: 20, outlineSize: 1, textColor: .white, outlineColor: .white)
        let restoreNSAS = outline(string: "RESTORE THIS APP", font: "NotoSansKR-Black", size: 20, outlineSize: 1, textColor: .white, outlineColor: .white)
        let opensourceNSAS = outline(string: "OPEN SOURCE", font: "NotoSansKR-Black", size: 20, outlineSize: 1, textColor: .white, outlineColor: .white)
        let contactNSAS = outline(string: "CONTACT", font: "NotoSansKR-Black", size: 20, outlineSize: 1, textColor: .white, outlineColor: .white)
        
        backupButton.setAttributedTitle(backupNSAS, for: .normal)
        restoreButton.setAttributedTitle(restoreNSAS, for: .normal)
        openSourceButton.setAttributedTitle(opensourceNSAS, for: .normal)
        contactButton.setAttributedTitle(contactNSAS, for: .normal)
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func backButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


