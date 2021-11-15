//
//  MemoListViewController.swift
//  Memo Project
//
//  Created by 배경원 on 2021/11/08.
//

import UIKit
import RealmSwift
import Realm


class MemoListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    let localRealm = try! Realm()
    var tasks: Results<MemoList>!
    
    let searchController = UISearchController(searchResultsController: nil)
    var filteredTasks: Results<MemoList>!
    var pinnedTasks: Results<MemoList>! {
        didSet {
            tableView.reloadData()
        }
    }
    var unpinnedTasks: Results<MemoList>! {
        didSet {
            tableView.reloadData()
        }
    }
    
    func searchBarIsEmpty() -> Bool {
          // Returns true if the text is empty or nil
          return searchController.searchBar.text?.isEmpty ?? true
        }
        
    func isFiltering() -> Bool {
          return searchController.isActive && !searchBarIsEmpty()
        }
    
    
    func showPopUp() {
        let storyboard = UIStoryboard(name: "Popup", bundle: nil)
        let pv = storyboard.instantiateViewController(withIdentifier: "Popup") as! PopupViewController
        
        pv.modalPresentationStyle = .overCurrentContext
        
        self.present(pv, animated: false, completion: nil)
        
    }
    
    
    

   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        tasks = localRealm.objects(MemoList.self)
        
        if Storage.isFirstTime() {
            showPopUp()
        } else {
            
        }
        
        pinnedTasks = tasks.filter("pinned = true")
        unpinnedTasks = tasks.filter("pinned = false")
        
        
        
        
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.title = "\(tasks.count)개의 메모"
        navigationItem.hidesSearchBarWhenScrolling = false
        
        self.navigationItem.searchController = searchController
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = .white
        
        let nibName = UINib(nibName: "MemoTableViewCell", bundle: nil)
        
        tableView.register(nibName, forCellReuseIdentifier: MemoTableViewCell.identifier)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "\(tasks.count)개의 메모"
        tableView.reloadData()
    }
    

    @IBAction func writeButtonClicked(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Editor", bundle: nil)
        let ev = storyboard.instantiateViewController(withIdentifier: "Editor") as! EditorViewController
        
        let backBarItem = UIBarButtonItem(title: "뒤로", style: .plain, target: self, action: nil)
        
        self.navigationItem.backBarButtonItem = backBarItem
        
        ev.previousTaskId = nil
        
        self.navigationController?.pushViewController(ev, animated: true)

    }
    
    
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
//            filteredTasks = tasks.filter({ (memo: MemoList) -> Bool in
//                return memo.content.lowercased().contains(searchText.lowercased())
//            })
        filteredTasks = tasks.filter("content CONTAINS[c] %@", searchText)
        self.tableView.reloadData()
    }
    

}
//end of class

extension MemoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("a", searchController.isActive)
        
        if searchController.isActive {
            if section == 1 {
                print("section1 is active true num")
                return filteredTasks.count
            } else {
                print("section 0 is active true num")
                return 0
            }
            
        } else {
            if section == 0 {
                return pinnedTasks.count
            } else {
                return unpinnedTasks.count
            }
            
        }
        
       
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if pinnedTasks.count == 0 && section == 0 {
            return 0
        }
        
        if searchController.isActive {
            return 0
        }
        
        return 40
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = .clear
//
//        let myLabel = UILabel()
//        myLabel.frame = CGRect(x: 10, y: 0, width: 150, height: 40)
//        myLabel.textAlignment = .left
//        myLabel.textColor = .white
//        myLabel.font = UIFont.boldSystemFont(ofSize: 18)
//
//
//        if section == 0 {
//            myLabel.text = "고정된 메모"
//
//        } else if section == 1 {
//            if searchController.isActive {
//                myLabel.text = "검색결과"
//            } else {
//                myLabel.text = "메모"
//            }
//
//        }
//
//        headerView.addSubview(myLabel)
//
//        return headerView
//    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        
        if section == 0 {
            return "고정된 메모"
        } else {
            if searchController.isActive {
                return "\(filteredTasks.count)개의 결과"
            } else {
                return "메모"
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if searchController.isActive {
            if filteredTasks[indexPath.row].pinned {
                let unpinAction = UIContextualAction(style: .normal, title: "") { Action, view, completionHandler in
                    completionHandler(true)
                    let taskToUpdate = self.filteredTasks[indexPath.row]
                try! self.localRealm.write {
                    taskToUpdate.pinned.toggle()
                }
                    self.tableView.reloadData()
            }
                unpinAction.backgroundColor = .red
                unpinAction.image = UIImage(systemName: "pin.slash.fill")
                
                return UISwipeActionsConfiguration(actions: [unpinAction])
                
            } else {
                let pinAction = UIContextualAction(style: .normal, title: "") { ACTION, view, completionHandler in
                    completionHandler(true)
                    
                    if self.pinnedTasks.count < 5 {
                        let taskToUpdate = self.filteredTasks[indexPath.row]
                        try! self.localRealm.write {
                            taskToUpdate.pinned.toggle()
                        }
                        self.tableView.reloadData()
                    } else {
                        let alert = UIAlertController(title: "앙대요", message: "앙대앙대요, 5개 넘게는 안돼요, ㅠㅅ ㅠ", preferredStyle: .alert)
                        let okBtn = UIAlertAction(title: "알겠습니다", style: .default, handler: nil)
                        
                        alert.addAction(okBtn)
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    
                    
                }
                pinAction.backgroundColor = .green
                pinAction.image = UIImage(systemName: "pin.fill")
                
                return UISwipeActionsConfiguration(actions: [pinAction])
                
            }
            
        } else {
            if indexPath.section == 0 {
                    let unpinAction = UIContextualAction(style: .normal, title: "") { Action, view, completionHandler in
                        completionHandler(true)
                        let taskToUpdate = self.pinnedTasks[indexPath.row]
                    try! self.localRealm.write {
                        taskToUpdate.pinned.toggle()
                    }
                        self.tableView.reloadData()
                }
                    unpinAction.backgroundColor = .red
                    unpinAction.image = UIImage(systemName: "pin.slash.fill")
                    
                    return UISwipeActionsConfiguration(actions: [unpinAction])
                
                            
                } else {
                    let pinAction = UIContextualAction(style: .normal, title: "") { ACTION, view, completionHandler in
                        completionHandler(true)
                        
                        if self.pinnedTasks.count < 5 {
                            let taskToUpdate = self.unpinnedTasks[indexPath.row]
                            try! self.localRealm.write {
                                taskToUpdate.pinned.toggle()
                            }
                            self.tableView.reloadData()
                        } else {
                            let alert = UIAlertController(title: "앙대요", message: "앙대앙대요, 5개 넘게는 안돼요, ㅠㅅ ㅠ", preferredStyle: .alert)
                            let okBtn = UIAlertAction(title: "알겠습니다", style: .default, handler: nil)
                            
                            alert.addAction(okBtn)
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                        
                        
                    }
                    pinAction.backgroundColor = .green
                    pinAction.image = UIImage(systemName: "pin.fill")
                    
                    return UISwipeActionsConfiguration(actions: [pinAction])
                }
        }

        
        }
       

    
//    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//
//
//        if indexPath.section == 0 {
//                let unpinAction = UIContextualAction(style: .normal, title: "") { Action, view, completionHandler in
//                    completionHandler(true)
//                    let taskToUpdate = self.pinnedTasks[indexPath.row]
//                try! self.localRealm.write {
//                    taskToUpdate.pinned.toggle()
//                }
//                    self.tableView.reloadData()
//            }
//                unpinAction.backgroundColor = .red
//                unpinAction.image = UIImage(systemName: "pin.slash.fill")
//
//                return UISwipeActionsConfiguration(actions: [unpinAction])
//
//
//            } else {
//                let pinAction = UIContextualAction(style: .normal, title: "") { ACTION, view, completionHandler in
//                    completionHandler(true)
//
//                    if self.pinnedTasks.count < 5 {
//                        let taskToUpdate = self.unpinnedTasks[indexPath.row]
//                        try! self.localRealm.write {
//                            taskToUpdate.pinned.toggle()
//                        }
//                        self.tableView.reloadData()
//                    } else {
//                        let alert = UIAlertController(title: "앙대요", message: "앙대앙대요, 5개 넘게는 안돼요, ㅠㅅ ㅠ", preferredStyle: .alert)
//                        let okBtn = UIAlertAction(title: "알겠습니다", style: .default, handler: nil)
//
//                        alert.addAction(okBtn)
//                        self.present(alert, animated: true, completion: nil)
//                    }
//
//
//
//                }
//                pinAction.backgroundColor = .green
//                pinAction.image = UIImage(systemName: "pin.fill")
//
//                return UISwipeActionsConfiguration(actions: [pinAction])
//            }
//
//
//
//
//
//        }
//
//
    
            
            
            
        
        
        
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "delete") { Action, view, completion in
            let taskToDelete = self.tasks[indexPath.row]
            try! self.localRealm.write {
                self.localRealm.delete(taskToDelete)
                
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.tasks.count)개의 메모"
            }
            
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
   
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoTableViewCell.identifier, for: indexPath) as? MemoTableViewCell else { return UITableViewCell()
        }

//        let row = tasks[indexPath.row]
        
//        if searchController.isActive {
//            cell.titleLabel.text = filteredTasks[indexPath.row].title
//            cell.overviewLabel.text = filteredTasks[indexPath.row].content
//            cell.dateLabel.text = "\(filteredTasks[indexPath.row].writeDate)"
//
//        } else if indexPath.section == 0 {
//            cell.titleLabel.text = pinnedTasks[indexPath.row].title
//            cell.overviewLabel.text = pinnedTasks[indexPath.row].content
//            cell.dateLabel.text = "\(pinnedTasks[indexPath.row].writeDate)"
//        } else if indexPath.section == 1 {
//            cell.titleLabel.text = unpinnedTasks[indexPath.row].title
//            cell.overviewLabel.text = unpinnedTasks[indexPath.row].content
//            cell.dateLabel.text = "\(unpinnedTasks[indexPath.row].writeDate)"
//        } else {
//
//        }
        
        if indexPath.section == 0 {
            
                print("section 0 is active false")
                cell.titleLabel.text = pinnedTasks[indexPath.row].title
                cell.overviewLabel.text = pinnedTasks[indexPath.row].content
                cell.dateLabel.text = "\(pinnedTasks[indexPath.row].writeDate)"
            
            return cell
            
        } else {
            if searchController.isActive {
                print("sec1 isactive true")
                cell.titleLabel.text = filteredTasks[indexPath.row].title
                cell.overviewLabel.text = filteredTasks[indexPath.row].content
                cell.dateLabel.text = "\(filteredTasks[indexPath.row].writeDate)"
                
            } else {
                print("section1 false")
                cell.titleLabel.text = unpinnedTasks[indexPath.row].title
                cell.overviewLabel.text = unpinnedTasks[indexPath.row].content
                cell.dateLabel.text = "\(unpinnedTasks[indexPath.row].writeDate)"
            }
            
        }

        return cell

    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Editor", bundle: nil)
        let ev = storyboard.instantiateViewController(withIdentifier: "Editor") as! EditorViewController
        
        let backBarItem = UIBarButtonItem(title: "뒤로", style: .plain, target: self, action: nil)
        
        let row = tasks[indexPath.row]
        
        self.navigationItem.backBarButtonItem = backBarItem
        
        if indexPath.section == 0 {
            if searchController.isActive {
                ev.previousTaskId = filteredTasks[indexPath.row]._id
                ev.index = indexPath
                ev.content = filteredTasks[indexPath.row].content
                ev.titleText = filteredTasks[indexPath.row].title
                
            } else {
                ev.previousTaskId = pinnedTasks[indexPath.row]._id
                ev.index = indexPath
                ev.content = pinnedTasks[indexPath.row].content
                ev.titleText = pinnedTasks[indexPath.row].title
                
            }
                    
        } else if indexPath.section == 1 {
            ev.previousTaskId = unpinnedTasks[indexPath.row]._id
            ev.index = indexPath
            ev.content = unpinnedTasks[indexPath.row].content
            ev.titleText = unpinnedTasks[indexPath.row].title
            
        } else {
            
        }
        
        
//        ev.previousTaskId = tasks[indexPath.row]._id
//        ev.index = indexPath
//        ev.content = tasks[indexPath.row].content
//        ev.titleText = tasks[indexPath.row].title
        
        
        
        
        
        self.navigationController?.pushViewController(ev, animated: true)
        
        
    }




}

extension MemoListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
        
        tableView.reloadData()
    }
}

