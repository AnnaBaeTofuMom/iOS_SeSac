//
//  ProfileViewController.swift
//  Rife - Simple Run Life
//
//  Created by 배경원 on 2021/11/17.
//

import UIKit


class ProfileViewController: UIViewController {

    @IBOutlet var totalDistanceField: UITextField!
    @IBOutlet var mottoField: UITextField!
    @IBOutlet var heightField: UITextField!
    @IBOutlet var nameField: UITextField!
    @IBOutlet var mainView: UIView!
    @IBOutlet var editButton: UIButton!
    @IBOutlet var profileImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
        
        nameField.layer.borderColor = UIColor(red: 0.4941, green: 0.9922, blue: 0.6941, alpha: 1.0).cgColor
        nameField.layer.borderWidth = 1
        nameField.attributedPlaceholder = NSAttributedString(string: "YOUR NAME", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 0.4941, green: 0.9922, blue: 0.6941, alpha: 1.0)])
        
        
        heightField.layer.borderColor = UIColor(red: 0.4941, green: 0.9922, blue: 0.6941, alpha: 1.0).cgColor
        heightField.layer.borderWidth = 1
        heightField.attributedPlaceholder = NSAttributedString(string: "YOUR HEIGHT", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 0.4941, green: 0.9922, blue: 0.6941, alpha: 1.0)])
        
        mottoField.layer.borderColor = UIColor(red: 0.4941, green: 0.9922, blue: 0.6941, alpha: 1.0).cgColor
        mottoField.layer.borderWidth = 1
        mottoField.attributedPlaceholder = NSAttributedString(string: "YOUR MOTTO", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 0.4941, green: 0.9922, blue: 0.6941, alpha: 1.0)])
        
        totalDistanceField.layer.borderColor = UIColor(red: 0.4941, green: 0.9922, blue: 0.6941, alpha: 1.0).cgColor
        totalDistanceField.layer.borderWidth = 1
        totalDistanceField.text = "YOU DIDN'T RUN YET"
        
        
        
        
        
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

    @IBAction func tap(_ sender: Any) {
        view.endEditing(true)
    }
    @IBAction func saveButtonClicked(_ sender: UIButton) {
    }
    
}
