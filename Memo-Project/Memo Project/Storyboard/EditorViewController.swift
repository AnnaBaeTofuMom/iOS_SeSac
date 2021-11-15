//
//  EditorViewController.swift
//  Memo Project
//
//  Created by 배경원 on 2021/11/08.
//

import UIKit
import RealmSwift
import NotificationBannerSwift

class EditorViewController: UIViewController {
    
    let localRealm = try! Realm()
    var tasks: Results<MemoList>!
    
    var previousTaskId: ObjectId?
    var index: IndexPath?
    var content: String?
    var titleText: String?
    
    
    let babo = "바보"
    
    

    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(index)

        tasks = localRealm.objects(MemoList.self)
    
        print("this is taskID", previousTaskId)
        if previousTaskId == nil {
            
            
            navigationItem.rightBarButtonItems = [UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(addMemo))  ,UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up.fill"), style: .plain, target: self, action: #selector(showAlert))]
            textView.text = ""
            print("no task ID")
        } else {
            
            navigationItem.rightBarButtonItems = [UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(updateMemo))  ,UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up.fill"), style: .plain, target: self, action: #selector(showAlert))]
            print("have task ID")
            
            textView.text = "\(content!)"

        }

        

    }
    
    @objc func addMemo() {
       
        let firstSentence = textView.text.split(separator: "\n", maxSplits: 1, omittingEmptySubsequences: false)
        let task = MemoList(title: String(firstSentence[0]), content: textView.text, writeDate: Date(), pinned: false)

        try! localRealm.write {
            localRealm.add(task)
        }
        print("Memo Newly Added")
        let banner = NotificationBanner(title: "새로운 메모 저장", subtitle: "오늘도 메모하는 습관!", style: .success)
        banner.show()
        

    }
    
    @objc func updateMemo() {
        let firstSentence = textView.text.split(separator: "\n", maxSplits: 1, omittingEmptySubsequences: false)
        try! localRealm.write {
            let memo = MemoList(value: ["_id": previousTaskId, "title": String(firstSentence[0]), "content": textView.text, "writeDate": Date() ])
            localRealm.add(memo, update: .modified)
        }
        print("memo updated")
        let banner = NotificationBanner(title: "메모 업데이트 완료", subtitle: "오늘도 메모하는 습관!", style: .success)
        banner.show()

    }
    
    @objc func showAlert() {
        let alert = UIAlertController(title: "미안합니다", message: "공유는 못해요", preferredStyle: .alert)
        
        let okBtn = UIAlertAction(title: "킹정합니다", style: .default, handler: nil)
        alert.addAction(okBtn)
        
        present(alert, animated: true, completion: nil)


}
}
