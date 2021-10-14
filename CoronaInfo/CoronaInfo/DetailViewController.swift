//
//  DetailViewController.swift
//  CoronaInfo
//
//  Created by minimani on 2021/10/14.
//

import UIKit
import Alamofire
import SwiftyJSON

class DetailViewController: UIViewController {
    
    var hospitals: [String:Any]?
    let API_KEY = ""
    var lat: String?
    var lon: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let hospital = self.hospitals,
              let address = hospital["orgZipaddr"] as? String else {return}
        getCode(query: address)
        
        let mapView = MTMapView(frame: self.view.bounds)
        mapView.baseMapType = .standard
        self.view.addSubview(mapView)
    }
    
    func getCode(query: String){
        let strURL = "https://dapi.kakao.com/v2/local/search/address.json"
        let params: Parameters = ["query": query]
        let headers: HTTPHeaders = ["Authorization":API_KEY]
        
        let request = AF.request(strURL, method: .get, parameters: params, headers: headers)
        request.response { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.lat = json["documents"].arrayValue[0]["y"].string
                self.lon = json["documents"].arrayValue[0]["x"].string
                print(self.lat, self.lon)
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
