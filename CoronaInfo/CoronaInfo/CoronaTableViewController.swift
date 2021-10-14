//
//  CoronaTableViewController.swift
//  CoronaInfo
//
//  Created by minimani on 2021/10/14.
//

import UIKit
import Alamofire
import SwiftyJSON

class CoronaTableViewController: UITableViewController, UISearchBarDelegate {
    
    let SERVICE_KEY = "iGmpA8Nig1A6KiflTrlTLWr6eOjrMeOdLIegfAC0JvrjrwU5mgRXpHvyPQQhF6MlX2LWhexdWuRhIW5ZyAchIA=="
    var hospitals: [[String:Any]]?

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    func search(query: String) {
        let strURL = "https://api.odcloud.kr/api/apnmOrg/v1/list"
        let params: Parameters = ["serviceKey":SERVICE_KEY, "cond[orgZipaddr::LIKE]":query]
        let request = AF.request(strURL, method: .get, parameters: params)
        
        request.responseJSON { response in
            switch response.result {
            case .success(let value):
                let root = JSON(value)
                self.hospitals = root["data"].arrayObject as? [[String:Any]]
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                if let message = error.errorDescription {
                    print(message)
                }
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let hospitals = hospitals {
            return hospitals.count
        } else {
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        guard let hospitals = self.hospitals else {return cell}
        let item = hospitals[indexPath.row]
        
        cell.textLabel?.text = item["orgnm"] as? String
        
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let q = searchBar.text {
            search(query: q)
        }
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

    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destVC = segue.destination as? DetailViewController,
              let indexPath = tableView.indexPathForSelectedRow,
              let hospitals = self.hospitals
        else {return}
        
        let hospital = hospitals[indexPath.row]
        
        destVC.hospitals = hospital
    }
    

}
