//
//  HospitalTableViewController.swift
//  CoronaXMLParsing
//
//  Created by minimani on 2021/10/12.
//

import UIKit

class HospitalTableViewController: UITableViewController {
    
    let serviceKey = "iGmpA8Nig1A6KiflTrlTLWr6eOjrMeOdLIegfAC0JvrjrwU5mgRXpHvyPQQhF6MlX2LWhexdWuRhIW5ZyAchIA%3D%3D"
    
    var hospitals: [[String:Any]] = []
    var item: [String:Any] = [:]
    var key: String?

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.rowHeight = 100
        
    }
    
    func search(location: String) {
        let strUrl = "https://api.odcloud.kr/api/apnmOrg/v1/list?serviceKey=\(serviceKey)&returnType=XML&cond[orgZipaddr::LIKE]=\(location)"
        guard let url = URL(string: strUrl) else {return}
        
        let parser = XMLParser(contentsOf: url)
        parser?.delegate = self
        parser?.parse()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return hospitals.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath)

        print(hospitals)
        
        let hospital = hospitals[indexPath.row]
        let hospitalName = cell.viewWithTag(1) as? UILabel
        hospitalName?.text = hospital["orgnm"] as? String
        
        let address = cell.viewWithTag(2) as? UILabel
        address?.text = hospital["orgZipaddr"] as? String
        
        let code = cell.viewWithTag(3) as? UILabel
        code?.text = hospital["orgcd"] as? String
        
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

extension HospitalTableViewController: XMLParserDelegate {
    func parserDidStartDocument(_ parser: XMLParser) {
        
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "data" {
            hospitals.removeAll()
        } else if elementName == "item" {
            item = [:]
        } else if elementName == "col" {
            // key = elementName
            key = attributeDict["name"]
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if let key = self.key {
            item[key] = string
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            hospitals.append(item)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        tableView.reloadData()
    }
}

extension HospitalTableViewController: UISearchBarDelegate {
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
