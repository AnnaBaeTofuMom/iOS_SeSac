//
//  ViewController.swift
//  LEDBoard
//
//  Created by 경원이 on 2021/10/04.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var ViewBackground: UIView!
    
    @IBOutlet var wordTextView: UITextView!
    @IBOutlet var LanguageButton: UIButton!
    @IBOutlet var SendButton: UIButton!
    @IBOutlet var SearchTextField: UITextField!
    
    @IBOutlet var searchView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.isHidden = false
        searchView.backgroundColor = .black
        ViewBackground.backgroundColor = .black
        SearchTextField.isHidden = false
        SearchTextField.borderStyle = .roundedRect
        SearchTextField.layer.cornerRadius = 5
        SearchTextField.backgroundColor = .white
        SearchTextField.attributedPlaceholder =  NSAttributedString(string: "텍스트를 입력해 주세요", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        
        SendButton.layer.cornerRadius = 5
        SendButton.layer.borderWidth = 1
        SendButton.layer.borderColor = UIColor.black.cgColor
        SendButton.tintColor = .white
        SendButton.setTitle("보내기", for: .normal)
        SendButton.setTitleColor(UIColor.black, for: .normal)
        SendButton.titleLabel?.adjustsFontSizeToFitWidth = true
        SendButton.titleLabel?.numberOfLines = 1
        SendButton.titleLabel?.lineBreakMode = .byClipping
        
        LanguageButton.layer.cornerRadius = 5
        LanguageButton.layer.borderWidth = 1
        LanguageButton.layer.borderColor = UIColor.black.cgColor
        LanguageButton.tintColor = .white
        LanguageButton.setTitle("Aa", for: .normal)
        LanguageButton.setTitleColor(UIColor.red, for: .normal)
        LanguageButton.titleLabel?.adjustsFontSizeToFitWidth = true
        LanguageButton.titleLabel?.numberOfLines = 1
        LanguageButton.titleLabel?.lineBreakMode = .byClipping
        
        wordTextView.textAlignment = .center
        wordTextView.backgroundColor = .black
        wordTextView.textColor = UIColor.white
        wordTextView.font?.withSize(100)
        wordTextView.isEditable = false
        
    }

    @IBAction func sendButton(_ sender: UIButton) {
        wordTextView.text = SearchTextField.text
        
        
    }
    func getRandomColor() -> UIColor{
            
            let randomRed:CGFloat = CGFloat(drand48())
            
            let randomGreen:CGFloat = CGFloat(drand48())
            
            let randomBlue:CGFloat = CGFloat(drand48())
            
            return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
            
        }
    
    @IBAction func colorButtonClick(_ sender: UIButton) {
        wordTextView.textColor = getRandomColor()
        
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        if searchView.isHidden == true {
            searchView.isHidden = false
        } else {
            searchView.isHidden = true
        }
    }
    
    @IBAction func returnKeyClick(_ sender: UITextField) {
        view.endEditing(true)
    }
    
}

