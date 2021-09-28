//
//  BTSTableViewController.swift
//  PListDuplication
//
//  Created by minimani on 2021/09/28.
//

import UIKit

class BTSTableViewController: UITableViewController {
    
    var bts:NSMutableArray?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = editButtonItem
        
        let targetPath = getFileName("bts.plist")
        guard let sourcePath = Bundle.main.path(forResource: "bts", ofType: "plist") else {return}
        
        let fileManager = FileManager.default
        
        // 값 복사
        if !fileManager.fileExists(atPath: targetPath) {
            do {
                try fileManager.copyItem(atPath: sourcePath, toPath: targetPath)
            } catch {
               // 예외가 발생했을 때 처리
                print("복사 실패")
            }
        }
        
        // 복사한 파일 불러오기
        bts = NSMutableArray(contentsOfFile: targetPath)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        tableView.reloadData()
//    }
    
    @IBAction func exitFromAddVC(segue:UIStoryboardSegue) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let bts = self.bts {
            return bts.count
        } else {
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        guard let bts = self.bts,
              let member = bts[indexPath.row] as? [String:String]
        else {return cell}
        
        cell.textLabel?.text = member["stage_name"]

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            bts?.removeObject(at: indexPath.row)
            bts?.write(toFile: getFileName("bts.plist"), atomically: true)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        guard let bts = self.bts else {return}
        let temp = bts[fromIndexPath.row]
        bts.removeObject(at: fromIndexPath.row)
        bts.insert(temp, at: to.row)
        bts.write(toFile: getFileName("bts.plist"), atomically: true)
    }
    

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let destVC = segue.destination as? AddViewController else {return}
        destVC.bts = self.bts
    }
    

}
