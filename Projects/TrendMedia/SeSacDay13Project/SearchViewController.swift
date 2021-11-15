//
//  SearchViewController.swift
//  SeSacDay13Project
//
//  Created by 경원이 on 2021/10/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher


class SearchViewController: UIViewController, UITableViewDataSourcePrefetching {
    
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if movieData.count - 1 == indexPath.row {
                startPage += 10
                fetchMovieData(query: searchBar.text ?? "")
                print("무비데이터 개수 : \(movieData.count)")
            }
        }
    }
    
    
    //취소
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("취소 : \(indexPaths)")
    }
    
    var movieData: [MovieModel] = []
    
    
    
    var startPage = 1
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet var searchTableView: UITableView!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        searchBar.backgroundColor = .black
        searchBar.barTintColor = .black
        searchBar.searchTextField.textColor = .white
        searchBar.layer.cornerRadius = 10
        closeButton.tintColor = .white
        view.backgroundColor = .black
        
        searchTableView.delegate = self
        searchTableView.prefetchDataSource = self
        searchTableView.dataSource = self
        
        searchBar.delegate = self
        
        
        
    }
    
    func fetchMovieData(query: String) {
        
        if let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let url = "https://openapi.naver.com/v1/search/movie.json?query=\(query)&display=10&start=\(startPage)"
            
            let header: HTTPHeaders = [
                "X-Naver-Client-Id": "30E3ogxoMkHOdjhUWjB9",
                "X-Naver-Client-Secret": "3YjZXcUZVG"
            ]
        
            
        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print("JSON: \(json)")
                
                for item in json["items"].arrayValue {
                    
                    
                    let value = item["title"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                    let image = item["image"].stringValue
                    let link = item["link"].stringValue
                    let userRating = item["userRating"].stringValue
                    let sub = item["subtitle"].stringValue
                    
                    let data = MovieModel(titleData: value, imageData: image, linkData: link, userRatingData: userRating, subtitle: sub)
                    
                    self.movieData.append(data)
                    //print(data)
                    
                }
                //핵중요, 리로드 안해주면 아무것도 안뜨겠죠?
                self.searchTableView.reloadData()
                
                //print(self.movieData)
                
            case .failure(let error):
                print(error)
                }
            }
            
        }
        
    }
    
    @IBAction func closeButtonClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableCell", for: indexPath) as! SearchTableViewCell
        let url = URL(string: movieData[indexPath.row].imageData)
        
        cell.lbl1.text = movieData[indexPath.row].titleData
        cell.lbl2.text = movieData[indexPath.row].subtitle
        cell.lbl3.text = movieData[indexPath.row].userRatingData
        cell.img.kf.setImage(with: url, placeholder: UIImage(named: "squid_game"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
extension SearchViewController: UISearchBarDelegate {
    //검색버튼 눌렀을 떄 실행
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        if let text = searchBar.text {
            movieData.removeAll()
            startPage = 1
            fetchMovieData(query: text)
        }
        
    }
    //취소버튼 눌렀을 때 실행
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        movieData.removeAll()
        searchTableView.reloadData()
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    //서치바에 커서가 깜빡거리기 시작할때 인식
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print(#function)
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    //func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
     //
    //}
}

extension SearchViewController: UITableViewDelegate {
    
}

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet var img: UIImageView!
    @IBOutlet var lbl1: UILabel!
    @IBOutlet var lbl2: UILabel!
    @IBOutlet var lbl3: UILabel!
    
    
}
    
    

