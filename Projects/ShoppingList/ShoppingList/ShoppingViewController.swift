//
//  ShoppingViewController.swift
//  ShoppingList
//
//  Created by 배경원 on 2021/11/03.
//

import UIKit
import RealmSwift

class ShoppingViewController: UIViewController {
    
    let fileManager = FileManager()
    let localRealm = try! Realm()
    var tasks: Results<shoppingListObject>!

    @IBOutlet var shoppingTableView: UITableView!
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var shoppingTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        shoppingTableView.dataSource = self
        shoppingTableView.delegate = self
        
        tasks = localRealm.objects(shoppingListObject.self)
        
    }
    
    @IBAction func sortButtonClicked(_ sender: UIButton) {
        let alert = UIAlertController(title: "정렬방식", message: "정렬방식을 선택해주세요", preferredStyle: UIAlertController.Style.actionSheet)
        
        let ascendingSort = UIAlertAction(title: "오름차순", style: .default) { action in
            let ascendingSorted = self.tasks.sorted(byKeyPath: "name", ascending: true)
            self.tasks = ascendingSorted
            self.shoppingTableView.reloadData()
        }
        
        let descendingSort = UIAlertAction(title: "내림차순", style: .default) { action in
            let descendingSorted = self.tasks.sorted(byKeyPath: "name", ascending: false)
            self.tasks = descendingSorted
            self.shoppingTableView.reloadData()
            
        }
        
        let heartedSort = UIAlertAction(title: "즐겨찾기 순으로 정렬", style: .default) { action in
            let heartSorted = self.tasks.sorted(byKeyPath: "hearted", ascending: false)
            self.tasks = heartSorted
            self.shoppingTableView.reloadData()
        }
        
        let checkedSort = UIAlertAction(title: "완료 순으로 정렬", style: .default) { action in
            let checkedSorted = self.tasks.sorted(byKeyPath: "checked", ascending: false)
            self.tasks = checkedSorted
            self.shoppingTableView.reloadData()
        }
        
        alert.addAction(ascendingSort)
        alert.addAction(descendingSort)
        alert.addAction(heartedSort)
        alert.addAction(checkedSort)
        
        present(alert, animated: true, completion:  nil)


        
    }
    
    @IBAction func registerButtonClicked(_ sender: UIButton) {
        
        let task = shoppingListObject(name: shoppingTextView.text)
        try! localRealm.write {
            localRealm.add(task)
            print(task)
            shoppingTableView.reloadData()
            
        }
        
    }
    
    @IBAction func heartButtonClicked(_ sender: UIButton) {
        
        print("heart clicked")
        let taskToUpdate = tasks[sender.tag]
        
        try! localRealm.write {
            taskToUpdate.hearted = !taskToUpdate.hearted
        }
        
        shoppingTableView.reloadData()
        
    }
    @IBAction func checkboxClicked(_ sender: UIButton) {
        print("heart clicked")
        let taskToUpdate = tasks[sender.tag]
        
        try! localRealm.write {
            taskToUpdate.checked = !taskToUpdate.checked
        }
        
        shoppingTableView.reloadData()
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

extension ShoppingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell", for: indexPath) as? ShoppingTableViewCell else { return UITableViewCell() }
        
        let row = tasks[indexPath.row]
        cell.shoppingLabel.text = row.name
        if row.hearted == false {
            cell.heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            cell.heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            
        }
        
        if row.checked == false {
            cell.checkBoxButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        } else {
            cell.checkBoxButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            
        }
        
        cell.checkBoxButton.tag = indexPath.row
        cell.heartButton.tag = indexPath.row
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let taskToDelete = tasks[indexPath.row]
            try! localRealm.write {
                localRealm.delete(taskToDelete)
            }
            shoppingTableView.reloadData()
        }
    }
    
}
