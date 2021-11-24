//
//  RecordCalendarViewController.swift
//  Rife - Simple Run Life
//
//  Created by 경원이 on 2021/11/25.
//

import UIKit
import FSCalendar

class RecordCalendarViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var tableViewContainer: UIView!
    @IBOutlet var calendarContainer: UIView!
    @IBOutlet var calendarView: FSCalendar!
    @IBOutlet var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.setTitle("", for: .normal)
        

        // Do any additional setup after loading the view.
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
    
}
