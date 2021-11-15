//
//  MainViewController.swift
//  SeSacDay13Project
//
//  Created by 경원이 on 2021/10/19.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher


class MainViewController: UIViewController {
    @IBOutlet var mainTableView: UITableView!
    @IBOutlet weak var threeButtonView: UIView!
    
    var trendDataArray:[TrendModel] = []
    
    func trendDataFetch() {
        let key = "e6fa1891dc3fe512cba5db2e6f7500d0"
        let url = "https://api.themoviedb.org/3/trending/movie/day?api_key=e6fa1891dc3fe512cba5db2e6f7500d0"
        
        
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for item in json["results"].arrayValue {
                    let title = item["title"].stringValue
                    let hashtag = item["media_type"].stringValue
                    let overview = item["overview"].stringValue
                    
                    let data = TrendModel(titleData: title, mediaType: hashtag, overviewData: overview)
                    
                    self.trendDataArray.append(data)
                    
                    print(self.trendDataArray)
                    
                    self.mainTableView.reloadData()
                    
                }
            case .failure(let error):
                print(error)
                print("아무것도 안됐음")
                
            
            }
        
            
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("lalala")
        trendDataFetch()
        print(trendDataArray)
        
        threeButtonView.layer.cornerRadius = 10
        threeButtonView.layer.shadowOpacity = 0.1
        threeButtonView.layer.shadowOffset = CGSize.init(width: 5, height: 5)
        
        mainTableView.dataSource = self
        mainTableView.delegate = self
    
    }
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        let uvc = self.storyboard!.instantiateViewController(withIdentifier: "searchVC")
        
        
        uvc.modalPresentationStyle = .fullScreen
        
        self.present(uvc, animated: true)
        
    }
    

    @IBAction func listButtomClicked(_ sender: Any) {
        guard let tvc = self.storyboard?.instantiateViewController(withIdentifier: "TheaterListViewController") else { return
        }
        
        tvc.modalPresentationStyle = .fullScreen
        
        self.present(tvc, animated: true)
        
        print("clicked")
    }
    

    
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trendDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrendTableViewCell", for: indexPath) as! TrendTableViewCell
        
        
        
                cell.title.text = trendDataArray[indexPath.row].titleData
                cell.hashtag.text = trendDataArray[indexPath.row].mediaType
                cell.overview.text = trendDataArray[indexPath.row].overviewData
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    }
    
   

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cv = self.storyboard!.instantiateViewController(withIdentifier: "CastViewController")
        
        cv.modalPresentationStyle = .automatic
        
        self.navigationController?.pushViewController(cv, animated: true)
    }
    
}

class TrendTableViewCell: UITableViewCell {
    @IBOutlet var hashtag: UILabel!
    @IBOutlet var title: UILabel!
    @IBOutlet var overview: UILabel!

}
