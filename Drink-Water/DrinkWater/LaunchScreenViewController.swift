//
//  LaunchScreenViewController.swift
//  DrinkWater
//
//  Created by 경원이 on 2021/10/12.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    @IBOutlet var launchImageView: UIImageView!
    @IBOutlet var launchLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(hue: 0.4194, saturation: 1, brightness: 0.7, alpha: 1.0)
        launchLabel.text = "물마시기 ㅎㅅㅎ"
        launchImageView.image = UIImage(named: "1-1")
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
