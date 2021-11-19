//
//  RecordsViewController.swift
//  Rife - Simple Run Life
//
//  Created by 경원이 on 2021/11/18.
//

import UIKit

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
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
  
}

extension RecordsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Record", for: indexPath) as? RecordsTableViewCell
                
        else { return UITableViewCell() }
        
        return cell
    }
    
    
}


