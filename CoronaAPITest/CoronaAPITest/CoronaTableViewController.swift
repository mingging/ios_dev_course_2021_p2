//
//  CoronaTableViewController.swift
//  CoronaAPITest
//
//  Created by minimani on 2021/10/12.
//

import UIKit

class CoronaTableViewController: UITableViewController {
    
    let serviceKey = ""
    var hospitals: [[String:Any]]?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
//        search()
    }

    func search(location: String) {
        let strURL = "https://api.odcloud.kr/api/apnmOrg/v1/list?serviceKey=\(serviceKey)&cond[orgZipaddr::LIKE]=\(location)"
        guard let url = URL(string: strURL) else {return}
        let request = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: dataTaskHandler)
        task.resume()
        
    }
    
    
    
    func dataTaskHandler(data: Data?, response: URLResponse?, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard let data = data else {return}
        
        do {
            if let root = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                hospitals = root["data"] as? [[String:Any]]
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        } catch {
            
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let hospitals = self.hospitals {
            return hospitals.count
        } else {
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath)
        
        guard let hospitals = self.hospitals else {return cell}
        let hospital = hospitals[indexPath.row]
        
        let hospitalName = tableView.viewWithTag(1) as? UILabel
        hospitalName?.text = hospital["orgnm"] as? String
        
        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
   
}

extension CoronaTableViewController: UISearchBarDelegate {
    //검색
   func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    if let query = searchBar.text {
        let tempQuery = query as NSString
        print(query)
        guard let Querystr = tempQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        search(location: Querystr)
    }
       
       // 키보드 내리기
       searchBar.resignFirstResponder()

   }
}
