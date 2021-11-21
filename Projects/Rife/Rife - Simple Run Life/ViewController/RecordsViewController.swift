//
//  RecordsViewController.swift
//  Rife - Simple Run Life
//
//  Created by 경원이 on 2021/11/18.
//

import UIKit
import RealmSwift
import MapKit

let localRealm = try! Realm()
let task = localRealm.objects(RecordObject.self)


class RecordsViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.navigationController?.isNavigationBarHidden = true
        
        tableView.dataSource = self
        tableView.delegate = self
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
  
}

extension RecordsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 98
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let taskToDelete = task[indexPath.row]
        if editingStyle == .delete {
            try! localRealm.write {
                localRealm.delete(taskToDelete)
            }
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Record", for: indexPath) as? RecordsTableViewCell
                
                
        else { return UITableViewCell() }
        let image = UIImage(data: task[indexPath.row].image)
        let date = task[indexPath.row].date
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "YYYY년 MM월 dd일 HH:mm"
        let stringDate = dateformatter.string(from: date)
        let distanceformatter = MKDistanceFormatter()
        distanceformatter.units = .metric
        let stringDistance = distanceformatter.string(fromDistance: task[indexPath.row].distance)
        
        
        
        
        
        cell.mapImageView.image = image
        cell.dateLabel.text = stringDate
        cell.distanceLabel.text = stringDistance
        cell.timeLabel.text = task[indexPath.row].time
        
        return cell
    }
    
    
}


