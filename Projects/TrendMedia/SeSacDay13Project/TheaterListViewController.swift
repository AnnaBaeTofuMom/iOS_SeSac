//
//  TheaterListViewController.swift
//  SeSacDay13Project
//
//  Created by 경원이 on 2021/10/24.
//

import UIKit

class TheaterListViewController: UIViewController {
    
    let theaterInformation: [(String, String, String, String, String)] =
    [("메가박스 강남", "서울특별시 서초구 서초동 서초대로77길 3", "+8215440070", "37.49797266180399", "127.02637516923029"),
        ("CGV 강남", "서울특별시 강남구 역삼동 강남대로 438", "+8215441122", "37.50168635340215", "127.02636191356486"),
        ("메가박스 코엑스", "서울특별시 강남구 삼성1동 봉은사로 524", "+8215440070", "37.5124361694687", "127.0588119558945"),
        ("메가박스 강남대로", "서울특별시 강남구 역삼동 강남대로 422", "+8215440070", "37.50042677045552", " 127.02694728965137"),
        ("CGV 청담 씨네시티", "서울특별시 강남구 신사동 651 21번지 14층", "+8215441122","37.52281466346784", "127.03700517666783")]

   

    @IBOutlet var userCurrentLocationLabel: UILabel!
    @IBOutlet var tableViewHeader: UIView!
    @IBOutlet var theaterTableView: UITableView!
    @IBOutlet var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        theaterTableView.dataSource = self
        theaterTableView.delegate = self
        
        
       
    }
    

    @IBAction func showDetailButtonClicked(_ sender: Any) {
        
        
        guard let mvc = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") else {
            return
            
        }
        

        
        mvc.modalPresentationStyle = .fullScreen
        
        self.present(mvc, animated: true)
    }
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension TheaterListViewController: UITableViewDelegate {
    

}

extension TheaterListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return theaterInformation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TheaterTableViewCell", for: indexPath) as? TheaterTableViewCell else {
            return UITableViewCell()
        }
        
        cell.theaterNameLabel.text = theaterInformation[indexPath.row].0 as? String
        cell.contactNumberLabel.text = theaterInformation[indexPath.row].2 as? String
        cell.theaterAddressLabel.text = theaterInformation[indexPath.row].1 as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    
}
