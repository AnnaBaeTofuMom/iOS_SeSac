//
//  CastViewController.swift
//  SeSacDay13Project
//
//  Created by 경원이 on 2021/10/21.
//

import UIKit

class CastViewController: UIViewController {

    @IBOutlet var castTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        castTableView.dataSource = self
        castTableView.delegate = self
      
    }
    

}

extension CastViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CastTableViewCell") else { return UITableViewCell() }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}

extension CastViewController: UITableViewDelegate {
    
}
