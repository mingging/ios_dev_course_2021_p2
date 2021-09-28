//
//  AddViewController.swift
//  PListDuplication
//
//  Created by minimani on 2021/09/28.
//

import UIKit

class AddViewController: UIViewController {

    var bts:NSMutableArray?

    @IBOutlet weak var txtName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func actDone(_ sender: UIButton) {
        guard let name = txtName.text else {return}
        let newbee = ["stage_name":name]
        bts?.add(newbee)
        bts?.write(toFile: getFileName("bts.plist"), atomically: true)
    }
    
    @IBAction func actBack(_ sender: UIButton) {
        performSegue(withIdentifier: "back", sender: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
