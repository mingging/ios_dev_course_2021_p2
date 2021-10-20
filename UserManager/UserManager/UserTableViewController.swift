//
//  UserTableViewController.swift
//  UserManager
//
//  Created by minimani on 2021/10/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class UserTableViewController: UITableViewController {
    
    var users: [[String:Any]]?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
//        loadUserInfo()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadUserInfo()
        tableView.reloadData()
    }

    func loadUserInfo() {
        let strURL = "http://localhost:8000/users/"
        let alamo = AF.request(strURL, method: .get)
        alamo.responseJSON { response in
            switch response.result {
            case .success(let value):
                let root = JSON(value)
                self.users = root["data"].arrayObject as? [[String:Any]]
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                if let error = error.errorDescription {
                    print(error)
                }
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let users = self.users {
            return users.count
        } else {
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let users = self.users else {return cell}
        let user = users[indexPath.row]
        
        let name = cell.viewWithTag(1) as? UILabel
        name?.text = user["name"] as? String

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destVC = segue.destination as? DetailUserViewController,
              let indexPath = tableView.indexPathForSelectedRow,
              let users = self.users
        else {return}
              
        let user = users[indexPath.row]
        
        destVC.user = user
        
    }
    

}
