//
//  DrinkWaterViewController.swift
//  DrinkWater
//
//  Created by 경원이 on 2021/10/11.
//

import UIKit

class DrinkWaterViewController: UIViewController {

    @IBOutlet var goalLabel: UILabel!
    @IBOutlet var pepTalkLabel: UILabel!
    @IBOutlet var plantImageView: UIImageView!
    @IBOutlet var recommendLabel: UILabel!
    @IBOutlet var profileViewButton: UIBarButtonItem!
    @IBOutlet var viewBackground: UIView!
    @IBOutlet var addWaterTextField: UITextField!
    @IBOutlet var drankWaterAmountLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        recommendLabel.text = "프로필을 입력하시면 권장량을 알려드려요!"

        viewBackground.backgroundColor =
        UIColor(hue: 0.4194, saturation: 1, brightness: 0.7, alpha: 1.0)
        drankWaterAmountLabel.text = "\(UserDefaults.standard.integer(forKey: "userSumWater"))ml"
        
        
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
    
    @IBAction func refreshClicked(_ sender: UIButton) {
        UserDefaults.standard.set(0, forKey: "userSumWater")
        drankWaterAmountLabel.text = "\(UserDefaults.standard.integer(forKey: "userSumWater"))ml"
        plantImageView.image = UIImage(named:"1-1")
        recommendLabel.text = "\(UserDefaults.standard.string(forKey: "userNickname")!)님의 하루 물 권장 섭취량은 \(UserDefaults.standard.double(forKey: "userWaterRecommend"))L입니다."
        pepTalkLabel.text = "잘 하셨어요!"
        pepTalkLabel.textColor = .black
    
    }
   
    @IBAction func addWaterClicked(_ sender: UIButton) {
        var previousSumWater = UserDefaults.standard.integer(forKey: "userSumWater")
        var addWaterTextFieldText = addWaterTextField.text
        var intAddWaterText = Int(addWaterTextFieldText!)
        var newSumWater = previousSumWater + intAddWaterText!
        
        UserDefaults.standard.set(newSumWater, forKey: "userSumWater")
        
        drankWaterAmountLabel.text = "\(UserDefaults.standard.integer(forKey: "userSumWater"))ml"
        
        goalLabel.text = "목표의 \(Int(UserDefaults.standard.double(forKey: "userWaterRecommend")) * UserDefaults.standard.integer(forKey: "userSumWter") / 100) %"
        
        if previousSumWater == 0 {
            plantImageView.image = UIImage(named:"1-1")
        }   else if newSumWater >= 100 && newSumWater < 500 {
            plantImageView.image = UIImage(named: "1-2")
            
        } else if newSumWater >= 500 && newSumWater < 1000 {
            plantImageView.image = UIImage(named: "1-3")
            
        } else if newSumWater >= 1000 && newSumWater < 1500 {
            plantImageView.image = UIImage(named: "1-4")
            
        } else if newSumWater >= 1500 && newSumWater < 2000 {
            plantImageView.image = UIImage(named: "1-5")
            
        } else if newSumWater >= 2000 && newSumWater < 2500 {
            plantImageView.image = UIImage(named: "1-6")
            
        } else if newSumWater >= 2500 && newSumWater < 3000 {
            plantImageView.image = UIImage(named: "1-7")
            
        } else if newSumWater >= 3000 && newSumWater < 3500 {
            plantImageView.image = UIImage(named: "1-8")
            
        } else if newSumWater >= 3500 && newSumWater < 4000 {
            plantImageView.image = UIImage(named: "1-9")
            pepTalkLabel.textColor = .red
            pepTalkLabel.text = "이제 그만!"
            
        }
        
        
        
    }
    
}

