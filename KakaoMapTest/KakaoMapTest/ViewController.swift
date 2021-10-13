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
        item1.customImageName = "pin"
        item1.markerSelectedType = .customImage
        item1.customSelectedImageName = "pin_sel"
        mapView?.add(item1)
    }
    
    @IBAction func actPin2(_ sender: UIButton) {
    }
}

extension ViewController: MTMapViewDelegate {
    func mapView(_ mapView: MTMapView!, touchedCalloutBalloonOf poiItem: MTMapPOIItem!) {
        print(poiItem.itemName!)
    }
    
}
