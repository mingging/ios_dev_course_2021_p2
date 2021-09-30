//
//  MyAnnotation.swift
//  MapViewTest
//
//  Created by minimani on 2021/09/29.
//

import UIKit
import MapKit

class MyAnnotation: NSObject, MKAnnotation{
    
    let title: String?
    let subtitle: String?
    let mapURL: String?
    var coordinate: CLLocationCoordinate2D
    let thumbNail: String?

     init(title: String, subtitle: String, mapURL: String, coordinate: CLLocationCoordinate2D, thumbNail: String) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.mapURL = mapURL
        self.thumbNail = thumbNail
        super.init()
    }
    
}
