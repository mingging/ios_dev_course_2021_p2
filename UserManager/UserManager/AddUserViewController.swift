//
//  AddUserViewController.swift
//  UserManager
//
//  Created by minimani on 2021/10/21.
//

import UIKit
import Alamofire

class AddUserViewController: UIViewController {

    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func createUser(id: String, name: String, password: String, address: String) {
        let strURL = "http://localhost:8000/users/"
        let params: Parameters = ["user_id":id, "name":name, "password":password, "address":address]
        let alamo = AF.request(strURL, method: .post, parameters: params)
        alamo.responseJSON { response in
            switch response.result {
            case .success(let value):
                print(value)
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            case .failure(let error):
                if let error = error.errorDescription {
                    print(error)
                }
            }
        }
    }
    
    @IBAction func actAddUser(_ sender: UIButton) {
        guard let id = idField.text,
              let name = nameField.text,
              let password = passwordField.text,
              let address = addressField.text
              else {return}
       
        createUser(id: id, name: name, password: password, address: address)
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
