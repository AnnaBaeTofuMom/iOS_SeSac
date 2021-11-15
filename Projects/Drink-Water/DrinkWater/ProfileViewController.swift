//
//  ProfileViewController.swift
//  DrinkWater
//
//  Created by 경원이 on 2021/10/11.
//

import UIKit
import TextFieldEffects

class ProfileViewController: UIViewController {

    @IBOutlet var profileImageView: UIImageView!
    
    @IBOutlet var navigationMenu: UINavigationItem!
    
    @IBOutlet var nicknameLabel: UILabel!
    @IBOutlet var weightTextField: MadokaTextField!
    @IBOutlet var heightTextField: MadokaTextField!
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var nicknameTextField: MadokaTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hue: 0.4194, saturation: 1, brightness: 0.7, alpha: 1.0)
        nicknameTextField.text = UserDefaults.standard.string(forKey: "userNickname")
        heightTextField.text = UserDefaults.standard.string(forKey: "userHeight")
        weightTextField.text = UserDefaults.standard.string(forKey: "userWeight")

        nicknameLabel.text = "닉네임"
        heightLabel.text = "키(cm)"
        weightLabel.text = "몸무게(kg)"
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        UserDefaults.standard.set(nicknameTextField.text, forKey: "userNickname")
        UserDefaults.standard.set(heightTextField.text, forKey: "userHeight")
        UserDefaults.standard.set(weightTextField.text, forKey: "userWeight")
        
        var userHeight = Double(UserDefaults.standard.string(forKey: "userHeight") ?? "0")!
        var userWeight = Double(UserDefaults.standard.string(forKey: "userWeight") ?? "0")!
        var waterAmount: Double = (userWeight + userHeight) / 100
        
        UserDefaults.standard.set(waterAmount, forKey: "userWaterRecommend")
    }
}
