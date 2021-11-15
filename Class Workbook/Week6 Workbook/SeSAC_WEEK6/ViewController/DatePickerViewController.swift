//
//  DatePickerViewController.swift
//  SeSAC_WEEK6
//
//  Created by 배경원 on 2021/11/05.
//

import UIKit
import FSCalendar

class DatePickerViewController: UIViewController {

    @IBOutlet var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker.preferredDatePickerStyle = .wheels
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
