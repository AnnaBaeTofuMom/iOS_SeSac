//
//  MainTabBarController.swift
//  SeSAC_WEEK6
//
//  Created by 경원이 on 2021/11/02.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.tabBar.items![0].title = "Home".localized()
        self.tabBarController?.tabBar.items![1].title = "Setting".localized()
        self.tabBarController?.tabBar.items![2].title = "Calendar".localized()
        self.tabBarController?.tabBar.items![3].title = "Search".localized()
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
