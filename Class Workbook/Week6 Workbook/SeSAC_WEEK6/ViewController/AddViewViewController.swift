//
//  AddViewViewController.swift
//  SeSAC_WEEK6
//
//  Created by 배경원 on 2021/11/01.
//

import UIKit
import RealmSwift
import NotificationBannerSwift

class AddViewViewController: UIViewController {
    
    let localRealm = try! Realm() //로컬의 Realm 저장소 위치를 알려줌
    
    
    
    @IBOutlet var uiView: UIView!
    @IBOutlet var contentImageView: UIImageView!
    @IBOutlet var datePickerButton: UIButton!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var detailTextView: UITextView!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* datePickerButton.setTitle("Please Select Date".localized(), for: .normal)
        titleTextField.text = "Title".localized()
        detailTextView.text = "Content".localized() */
        cancelButton.setTitle("Cancel".localized(), for: .normal)
        saveButton.setTitle("Save".localized(), for: .normal)
        
        print("Realm is located at : ", localRealm.configuration.fileURL)
        contentImageView.image = UIImage(named: "subi")
      
    }
    
    @IBAction func cancelButtonClicked(_ sender: UIButton) {
        
        self.dismiss(animated: true)
    }
    
    @IBAction func tapGestureTouched(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @IBAction func dateButtonClicked(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "날짜 선택", message: "날짜를 선택해 주세요.", preferredStyle: .alert)
        
        guard let contentView = self.storyboard?.instantiateViewController(withIdentifier: "DatePickerViewController") as? DatePickerViewController else { return }
        
        contentView.view.backgroundColor = .green
        
        alert.setValue(contentView, forKey: "contentViewController")
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default) { ACTION in
            
            let format = DateFormatter()
            format.dateFormat = "yyyy년 MM월 dd일"
            let value = format.string(from: contentView.datePicker.date)
            
            self.datePickerButton.setTitle(value, for: .normal)
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        let format = DateFormatter()
        
        format.dateFormat = "yyyy년 MM월 dd일"
        
        guard let date = datePickerButton.currentTitle, let value = format.date(from: date) else { return }
        
        let task = UserDiary(diaryTitle: titleTextField.text ?? "룰룰내용이없네요?", writeDate: value, content: detailTextView.text, regDate: Date())
        try! localRealm.write {
            localRealm.add(task)
            saveImageToDocumentDirectory(imageName: "\(task._id).png", image: contentImageView.image ?? UIImage())
        }
        let banner = StatusBarNotificationBanner(title: "저장 성공", style: .success)
        banner.show()
        
        
        
    }
    
    func saveImageToDocumentDirectory(imageName: String, image: UIImage) {
        
        //1. 이미지를 저장할 경로 설정: 도큐먼트 폴더, FileManager(싱글턴 패턴)
        // Desktop/jack/iOS/folder
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        //2. 이미지 파일이름(뭐가 될지모르니 매개변수로 넣어두기)
        // Desktop/jack/iOS/folder/222.png
        let imageURL = documentDirectory.appendingPathComponent(imageName)
        
        //3. 이미지 압축
        guard let data = image.pngData() else { return }
        
        //4. 이미지 저장: 동일한 경로에 이미지를 저장하게 될 경우 덮어쓰기(원래 자동으로 되긴 함)
        if FileManager.default.fileExists(atPath: imageURL.path) {
            //4-1. 기존의 경로에 있는 이미지 삭제
            do {
                try FileManager.default.removeItem(at: imageURL)
                print("이미지 삭제 완료")
            }   catch {
                print("이미지 삭제 실패")
            }
            
        }
        
        //5. 이미지를 도큐먼트에 저장
        do {
            try data.write(to: imageURL)
        } catch {
            print("이미지 저장 실패")
        }
        
        
    }
}
