//
//  SearchViewController.swift
//  SeSAC_WEEK6
//
//  Created by 배경원 on 2021/11/01.
//

import UIKit
import RealmSwift

class SearchViewController: UIViewController {

    let localRealm = try! Realm() //로컬의 Realm 저장소 위치를 알려줌
    
    @IBOutlet var searchTableView: UITableView!
    
    @IBOutlet var searchTabBarItem: UITabBarItem!
    
    var tasks: Results<UserDiary>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        // Get all tasks in the realm
        tasks = localRealm.objects(UserDiary.self)
        

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tasks = localRealm.objects(UserDiary.self)
        searchTableView.reloadData()
    }
    
    //도큐먼트 폴더 경로에서 이미지 찾고, 찾은 이미지 UIImage로 변환해서 UIImageView에 보여주기(이건 cellforrowat에서 보여주기)
    func loadImageFromDocumentDirectory(imageName: String) -> UIImage? {
        
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let directoryPath = path.first {
            let imageURL = URL(fileURLWithPath: directoryPath).appendingPathComponent(imageName)
            return UIImage(contentsOfFile: imageURL.path)
        }
        
        return nil
    }
    
    func deleteImageFromDocumentDirectory(imageName: String) {
        
        //1. 이미지를 저장할 경로 설정: 도큐먼트 폴더, FileManager(싱글턴 패턴)
        // Desktop/jack/iOS/folder
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        //2. 이미지 파일이름(뭐가 될지모르니 매개변수로 넣어두기)
        // Desktop/jack/iOS/folder/222.png
        let imageURL = documentDirectory.appendingPathComponent(imageName)
       
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
        
    }
        
    }



extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    //원래는 화면 전환 + 값 전달 후 새로운 화면에서 수정이 적합, 그냥 시간 없어서 이렇게 해봄
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskToUpdate = tasks[indexPath.row]
        
        //1. 수정 - 레코드에 대한 수정
            try! localRealm.write {
            taskToUpdate.diaryTitle = "바꿔 바꿔 모든걸 다 바꿔"
            taskToUpdate.content = "내용이즈내용"
            
            tableView.reloadData()
        }
        
        //2 일괄 수정
        /*try! localRealm.write {
            tasks.setValue(Date(), forKey: "writeDate")
            tasks.setValue("다바꾸는 마법", forKey: "diaryTitle")
            tableView.reloadData()
        }*/
        
        //3. 수정: pk 기준으로 수정할 때 사용(입력한 컬럼 이외에 다 날아감)
        /*try! localRealm.write {
            let update = UserDiary(value: ["_id" : taskToUpdate._id, "diaryTitle": "얘만 바꾸고 싶어"])
            localRealm.add(update, update: .modified)
            tableView.reloadData()
        }*/
        //4. 특정 컬럼만 수정
        /*try! localRealm.write {
            localRealm.create(UserDiary.self, value: ["_id" : taskToUpdate._id, "diaryTitle": "얘만 바꾸고 싶어"], update: .modified)
            tableView.reloadData()
        }*/
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell
        
        let row = tasks[indexPath.row]
        cell?.configureCell(row: row)
        
        
        
        cell?.searchImageView.image = loadImageFromDocumentDirectory(imageName: "\(row._id).png")
    
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        try! localRealm.write {
            
            deleteImageFromDocumentDirectory(imageName: "\(tasks[indexPath.row]._id).png")
            localRealm.delete(tasks[indexPath.row])
            searchTableView.reloadData()
        }
    }
    
    
}
