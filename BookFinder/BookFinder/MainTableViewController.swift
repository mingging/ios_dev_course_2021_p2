//
//  MainTableViewController.swift
//  BookFinder
//
//  Created by minimani on 2021/09/30.
//

import UIKit

class MainTableViewController: UITableViewController, UISearchBarDelegate {

    let apiKey = "KakaoAK "
    var books:[[String:Any]]?
    @IBOutlet weak var searchBar: UISearchBar!
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    func dataTaskHandler(data: Data?, response: URLResponse?, error: Error?) {
        guard let rData = data else {return}
        
        // json 형식으로 바꿔 줌
        do {
            if let dic = try JSONSerialization.jsonObject(with: rData, options: []) as? [String:Any] {
                //let meta = dic["meta"] as? [String:Any]
                books = dic["documents"] as? [[String:Any]]

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        } catch {
            print("실패")
        }
    }
    
    // 데이터 가져오기
    func search(query: String, page: Int) {
        let strURL = "https://dapi.kakao.com/v3/search/book?query=\(query)&page=\(page)" as NSString
        guard let str = strURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        print(strURL)
        print(str)
        guard let url = URL(string: str) else {return}
        var request = URLRequest(url: url)
        // 헤더 추가
        request.addValue(apiKey, forHTTPHeaderField: "Authorization")
        // 방식 설정
        request.httpMethod = "GET"
        // 세션 설정
        let session = URLSession.shared
        // 테스크 생성
        let dataTask = session.dataTask(with: request, completionHandler: dataTaskHandler)
        
        dataTask.resume()
    }

    // 검색
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {return}
        search(query: query, page: 1)
        // 키보드 내리기
        searchBar.resignFirstResponder()
        
    }
    
    // 다음 버튼
    @IBAction func actNext(_ sender: UIBarButtonItem) {
        page += 1
        guard let query = searchBar.text else {return}
        search(query: query, page: page)
    }
    
    // 이전 버튼
    @IBAction func actPrev(_ sender: UIBarButtonItem) {
        if (page > 0) {
            page -= 1
        } else {
            page = 0
        }
        guard let query = searchBar.text else {return}
        search(query: query, page: page)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let books = books {
            return books.count
        } else {
            return 0
        }
       
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookcell", for: indexPath)
        
        guard let books = self.books else {return cell}
        let book = books[indexPath.row]

        let bookTitle = cell.viewWithTag(1) as? UILabel
        bookTitle?.text = book["title"] as? String
        
        if let imageURL = book["thumbnail"] as? String,  let url = URL(string: imageURL) {
            // 이미지 다운로드
            do {
                let data = try Data(contentsOf: url)
                let thumbNail = cell.viewWithTag(2) as? UIImageView
                thumbNail?.image = UIImage(data: data)
            } catch {print("thumbnail download failed")}
           
        }

        return cell
    }
    
   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    // detail 가져오기
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destVC = segue.destination as? DetailViewController,
              let indexPath = tableView.indexPathForSelectedRow,
              let books = self.books
        else {return}
        
        let book = books[indexPath.row]
        
        destVC.strURL = book["url"] as? String
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    
    

}
