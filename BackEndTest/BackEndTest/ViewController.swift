//
//  ViewController.swift
//  BackEndTest
//
//  Created by minimani on 2021/10/20.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    let strURL = "http://localhost:8000/users/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func actPost(_ sender: Any) {
        let parmas:Parameters = ["user_id":"a01", "name":"도라지", "password":"pass", "address":"작두콩차"]
        let alamo = AF.request(strURL, method: .post, parameters: parmas)
        alamo.responseJSON { response in
            switch response.result {
            case .success(let value):
                print(value)
            case .failure(let error):
                if let error = error.errorDescription {
                    print(error)
                }
            }
        }
    }
    
    @IBAction func actGet(_ sender: Any) {
        let alamo = AF.request(strURL, method: .get)
        alamo.responseJSON { response in
            switch response.result {
            case .success(let value):
                print(value)
            case .failure(let error):
                if let error = error.errorDescription {
                    print(error)
                }
            }
        }
    }
    
    @IBAction func actPut(_ sender: Any) {
        let putUrl = "http://localhost:8000/users/1"
        let parmas:Parameters = ["user_id":"a03", "name":"미떼", "password":"pass", "address":"핫초코"]
        let alamo = AF.request(putUrl, method: .put, parameters: parmas)
        alamo.responseJSON { response in
            switch response.result {
            case .success(let value):
                print(value)
            case .failure(let error):
                if let error = error.errorDescription {
                    print(error)
                }
            }
        }
    }
    
    @IBAction func actDelete(_ sender: Any) {
        let putUrl = "http://localhost:8000/users/1"
        let alamo = AF.request(putUrl, method: .delete)
        alamo.responseJSON { response in
            switch response.result {
            case .success(let value):
                print(value)
            case .failure(let error):
                if let error = error.errorDescription {
                    print(error)
                }
            }
        }
    }
    
}

