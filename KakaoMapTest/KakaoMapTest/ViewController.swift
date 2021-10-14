//
//  ViewController.swift
//  KakaoMapTest
//
//  Created by minimani on 2021/10/13.
//

import UIKit

class ViewController: UIViewController {
    
    var mapView: MTMapView?

    @IBOutlet var view1: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = MTMapView(frame: view1.bounds)
        mapView?.delegate = self
        
        if let mapView = self.mapView {
            mapView.baseMapType = .standard
            
            let pointGeo = MTMapPointGeo(latitude: 37.62730240396438, longitude: 127.02607604998046)
            let mapPoint = MTMapPoint(geoCoord: pointGeo)
            mapView.setMapCenter(mapPoint, animated: true)
            mapView.setZoomLevel(1, animated: true)
            
            view1.addSubview(mapView)
        }
        
       
    }

    @IBAction func actPin1(_ sender: UIButton) {
        let item1 = MTMapPOIItem()
        let pointGeo = MTMapPointGeo(latitude: 37.62730240396438, longitude: 127.02607604998046)
        let mapPoint = MTMapPoint(geoCoord: pointGeo)
        item1.itemName = "미아역"
        item1.mapPoint = mapPoint
        item1.markerType = .customImage
        item1.customImageName = "pin_map"
        item1.markerSelectedType = .customImage
        item1.customSelectedImageName = "pin_map_down"
        mapView?.add(item1)
    }
    
    @IBAction func actPin2(_ sender: UIButton) {
        let item2 = MTMapPOIItem()
        let pointGeo = MTMapPointGeo(latitude: 37.6270, longitude: 127.02607604998046)
        let mapPoint = MTMapPoint(geoCoord: pointGeo)
        item2.itemName = "미아역 조금 아래"
        item2.mapPoint = mapPoint
        
        item2.markerType = .customImage
        item2.customImageName = "pin_map"
        
        item2.markerSelectedType = .customImage
        item2.customSelectedImageName = "pin_map_down"
        
        item2.imageNameOfCalloutBalloonLeftSide = "flag"
        item2.imageNameOfCalloutBalloonRightSide = "flag"
                
        mapView?.add(item2)
    }
}

extension ViewController: MTMapViewDelegate {
    func mapView(_ mapView: MTMapView!, touchedCalloutBalloonOf poiItem: MTMapPOIItem!) {
        if let name = poiItem.itemName {
            print("\(name) 터치됨")
        }
    }
    
    func mapView(_ mapView: MTMapView!, touchedCalloutBalloonLeftSideOf poiItem: MTMapPOIItem!) {
        if let name = poiItem.itemName {
            print("\(name) LeftSide 터치됨")
        }
    }
    
    func mapView(_ mapView: MTMapView!, touchedCalloutBalloonRightSideOf poiItem: MTMapPOIItem!) {
        if let name = poiItem.itemName {
            print("\(name) RightSide 터치됨")
        }
    }
    
}
