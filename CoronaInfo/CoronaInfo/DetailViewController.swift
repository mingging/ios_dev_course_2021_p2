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
    var lat: Double?
    var lon: Double?
    let mapView: MTMapView = MTMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let hospital = self.hospitals,
              let address = hospital["orgZipaddr"] as? String else {return}
        let mapView = MTMapView(frame: self.view.bounds)
        mapView.baseMapType = .standard
        self.view.addSubview(mapView)
        getCode(query: address)
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
                self.lat = json["documents"].arrayValue[0]["y"].doubleValue
                self.lon = json["documents"].arrayValue[0]["x"].doubleValue
                guard let lat = self.lat, let lon = self.lon else {return}
                let item = MTMapPOIItem()
                let pointGeo = MTMapPointGeo(latitude: lat, longitude: lon)
                let mapPoint = MTMapPoint(geoCoord: pointGeo)
                self.mapView.setMapCenter(mapPoint, animated: true)
                self.mapView.setZoomLevel(1, animated: true)
                item.mapPoint = mapPoint
                item.markerType = .redPin
                self.mapView.add(item)
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
