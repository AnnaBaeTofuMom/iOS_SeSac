//
//  ViewController.swift
//  NewWordDictionary
//
//  Created by 경원이 on 2021/10/05.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var answerLable: UILabel!
    @IBOutlet var searchButton: UIButton!
    
    @IBOutlet var searchTextField: UITextField!
    let dict = ["삼귀자" : "사귀기 전 썸타는 단계", "버카충" : "버스 카드 충전", "벼락거지" : "벼락부자의 반대말", "빵셔틀" : "빵을 사다주는 심부름꾼", "플렉스" : "부를 과시하는 것", "갑분싸" : "갑자기 분위기 싸해지다"]
    override func viewDidLoad() {
        super.viewDidLoad()
        answerLable.textColor = .black
        

        // Do any additional setup after loading the view.
    }

    @IBAction func tapGestureRecognizer(_ sender: UITapGestureRecognizer) {
        
        view.endEditing(true)
    }
    
    @IBAction func searchButtonClick(_ sender: UIButton) {
        
        if searchTextField.text?.isEmpty ?? true {
            answerLable.text = "검색어를 입력해주세요"
        } else {
            let searchWord = searchTextField.text
            let wordMeaning = dict[searchWord!]
            
            answerLable.text = wordMeaning
            
            }
        }
        
        
        
    }


