//
//  BTSTableViewController.swift
//  PListTest
//
//  Created by minimani on 2021/09/28.
//

import UIKit

class BTSTableViewController: UITableViewController {
    
    var bts:NSArray?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let path = Bundle.main.path(forResource: "bts", ofType: "plist") else { return }
        bts = NSArray(contentsOfFile: path)
        
        tableView.rowHeight = 100
    }
    
//    func plistLoad() -> Any{
//        if let path = Bundle.main.path(forResource: "bts", ofType: "plist") {
//            if let bts = NSArray(contentsOfFile: path) {
//                return bts
//            }
//        }
//        return 0
//    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let bts = self.bts {
            return bts.count
        } else {
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath)
        
        guard let bts = self.bts, let dic = bts[indexPath.row] as? [String:String] else {return cell}
        
        if let imageView = cell.viewWithTag(1) as? UIImageView,
           let imageName = dic["image"] {
            imageView.image = UIImage(named: imageName)
        }
                
        if let stageName = cell.viewWithTag(2) as? UILabel {
            stageName.text = dic["stage_name"]
        }
                
                
        if let name = cell.viewWithTag(3) as? UILabel {
            name.text = dic["name"]
        }
       
        
      

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
