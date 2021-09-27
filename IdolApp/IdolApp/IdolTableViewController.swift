//
//  IdolTableViewController.swift
//  IdolApp
//
//  Created by minimani on 2021/09/27.
//

import UIKit

class IdolTableViewController: UITableViewController {
    

    var seolInfo = [["title": "혀 내민 설이", "cute":"10", "img":"seol2"],
                    ["title": "공부하는 설이", "cute":"9", "img":"seol5"], ["title":"째려보는 설이", "cute":"10", "img":"seol3"], ["title":"잠 자기 전 설이", "cute":"9", "img":"seol1"], ["title":"쳐다보는 설이", "cute":"9", "img":"seol4"]]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    @IBAction func actFavorites(_ sender: UIButton) {
        if (!sender.isSelected) {
            sender.setImage(UIImage(named: "star-fill.png"), for: .normal)
            sender.isSelected = true
        } else {
            sender.setImage(UIImage(named: "star.png"), for: .normal)
            sender.isSelected = false
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return seolInfo.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath)
        let dic = seolInfo[indexPath.row]
        
//        let imageView = cell.viewWithTag(1) as? UIImageView
//        imageView?.image = UIImage(named: dic["img"]!)
        if let imageView = cell.viewWithTag(1) as? UIImageView {
            if let imageName = dic["img"] {
                imageView.image = UIImage(named: imageName)
            }
        }

//        let titleLabel = cell.viewWithTag(2) as? UILabel
//        titleLabel?.text = dic["title"]
        if let lblTitle = cell.viewWithTag(2) as? UILabel {
            lblTitle.text = dic["title"]
        }
        
//        let cuteLabel = cell.viewWithTag(3) as? UILabel
//        cuteLabel?.text = dic["cute"]
        if let lblCute = cell.viewWithTag(3) as? UILabel {
            lblCute.text = dic["cute"]
        }

        // Configure the cell...

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let indexPath = tableView.indexPathForSelectedRow {
            if let destVC = segue.destination as? DetailViewController {
                destVC.info = seolInfo[indexPath.row]
            }
        }
    }

}
