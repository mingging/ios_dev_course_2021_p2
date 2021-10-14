//
//  ViewController.swift
//  GeocodingTest
//
//  Created by minimani on 2021/10/14.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    let API_KEY = "KakaoAK d28439fff0e8792c783d41dcea5cebdb"

    @IBOutlet weak var lblLongitude: UILabel!
    @IBOutlet weak var lblLatitude: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func actSearch(_ sender: UIButton) {
        let query = "서울특별시 금천구 디지털로 9길 56"
        getCode(query: query)
    }
    
    func getCode(query: String) {
        let strURL = "https://dapi.kakao.com/v2/local/search/address.json"
        let params: Parameters = ["query":query]
        let headers: HTTPHeaders = ["Authorization":API_KEY]
        
        let alamo = AF.request(strURL, method: .get, parameters: params, headers: headers)
        
        alamo.responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let lat = json["documents"].arrayValue[0]["y"].string
                let lon = json["documents"].arrayValue[0]["x"].string
                
                DispatchQueue.main.async {
                    self.lblLatitude.text = lat
                    self.lblLongitude.text = lon
                }
                
             case .failure(let error):
                if let desc = error.errorDescription {
                    print(desc)
                }
            }
        }
    }
}

