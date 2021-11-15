
//func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//    
//    if isFiltering() {
//        if filteredTasks[indexPath.row].pinned {
//            let unpinAction = UIContextualAction(style: .normal, title: "") { Action, view, completionHandler in
//                completionHandler(true)
//                let taskToUpdate = self.pinnedTasks[indexPath.row]
//            try! self.localRealm.write {
//                taskToUpdate.pinned.toggle()
//            }
//                self.tableView.reloadData()
//        }
//            unpinAction.backgroundColor = .red
//            unpinAction.image = UIImage(systemName: "pin.slash.fill")
//            
//            return UISwipeActionsConfiguration(actions: [unpinAction])
//            
//        } else {
//            let pinAction = UIContextualAction(style: .normal, title: "") { ACTION, view, completionHandler in
//                completionHandler(true)
//                
//                if self.pinnedTasks.count < 5 {
//                    let taskToUpdate = self.unpinnedTasks[indexPath.row]
//                    try! self.localRealm.write {
//                        taskToUpdate.pinned.toggle()
//                    }
//                    self.tableView.reloadData()
//                } else {
//                    let alert = UIAlertController(title: "앙대요", message: "앙대앙대요, 5개 넘게는 안돼요, ㅠㅅ ㅠ", preferredStyle: .alert)
//                    let okBtn = UIAlertAction(title: "알겠습니다", style: .default, handler: nil)
//                    
//                    alert.addAction(okBtn)
//                    self.present(alert, animated: true, completion: nil)
//                }
//                
//                
//                
//            }
//            pinAction.backgroundColor = .green
//            pinAction.image = UIImage(systemName: "pin.fill")
//            
//            return UISwipeActionsConfiguration(actions: [pinAction])
//            
//        }
//        
//    } else {
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
//    }
//
//    
//    }
//   
