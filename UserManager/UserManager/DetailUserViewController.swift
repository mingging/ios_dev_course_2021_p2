//
//  DetailUserViewController.swift
//  UserManager
//
//  Created by minimani on 2021/10/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class DetailUserViewController: UIViewController {
    
    var user: [String:Any]?
    var id: Int?
    
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let user = self.user else {return}
        idField.text = user["user_id"] as? String
        nameField.text = user["name"] as? String
        passwordField.text = user["password"] as? String
        addressField.text = user["address"] as? String
        id = user["id"] as? Int
        // Do any additional setup after loading the view.
    }
    
    func updateUser(user_id: String, name: String, password: String, address: String) {
        guard let id = id else {return}
        let strUrl = "http://localhost:8000/users/\(id)"
        let params: Parameters = ["user_id":user_id, "name":name, "password":password, "address":address]
        let alamo = AF.request(strUrl, method: .put, parameters: params)
        alamo.responseJSON { response in
            switch response.result {
            case .success(let value):
                print(value)
                let alert = UIAlertController(title: "유저 업데이트", message: "유저 업데이트에 성공했습니다.", preferredStyle: .alert)
                let ok_action = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(ok_action)
                self.present(alert, animated: true)
            case .failure(let error):
                if let error = error.errorDescription {
                    print(error)
                }
            }
        }
    }
    
    
    @IBAction func actEdit(_ sender: Any) {
        guard let user_id = idField.text,
              let name = nameField.text,
              let password = passwordField.text,
              let address = addressField.text
        else {return}
        
        updateUser(user_id: user_id, name: name, password: password, address: address)
    }
    
    @IBAction func actDelete(_ sender: Any) {
        guard let id = id else {return}
        let strUrl = "http://localhost:8000/users/\(id)"
        let alamo = AF.request(strUrl, method: .delete)
        alamo.responseJSON { response in
            switch response.result {
            case .success(let value):
                print(value)
                let alert = UIAlertController(title: "유저 삭제", message: "유저 삭제가 완료되었습니다.", preferredStyle: .alert)
                let ok_action = UIAlertAction(title: "확인", style: .default) { ACTION in
                    self.navigationController?.popViewController(animated: true)
                }
                alert.addAction(ok_action)
                self.present(alert, animated: true)
            case .failure(let error):
                if let error = error.errorDescription {
                    print(error)
                }
            }
        }
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
