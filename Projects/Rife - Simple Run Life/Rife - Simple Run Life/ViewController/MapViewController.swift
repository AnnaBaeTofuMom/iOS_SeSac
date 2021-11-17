//
//  MapViewController.swift
//  Rife - Simple Run Life
//
//  Created by 배경원 on 2021/11/17.
//

import UIKit
import SideMenu

class MapViewController: UIViewController {

    @IBOutlet var navigationBar: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.layer.borderWidth = 1
        navigationBar.layer.borderColor = UIColor(named: "black")?.cgColor
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
}
