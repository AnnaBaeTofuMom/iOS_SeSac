//
//  CalendarViewController.swift
//  SeSAC_WEEK6
//
//  Created by 배경원 on 2021/11/05.
//

import UIKit
import FSCalendar
import RealmSwift

class CalendarViewController: UIViewController {
    
    let localRealm = try! Realm()
    
    var tasks: Results<UserDiary>!

    @IBOutlet var calendarView: FSCalendar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasks = localRealm.objects(UserDiary.self)

        calendarView.delegate = self
        calendarView.dataSource = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        calendarView.reloadData()
    }
    


}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        return tasks.filter("writeDate == %@", date).count
    }
    
}
