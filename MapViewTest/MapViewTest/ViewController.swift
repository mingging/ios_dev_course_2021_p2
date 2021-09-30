//
//  ViewController.swift
//  MapViewTest
//
//  Created by minimani on 2021/09/29.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let location = CLLocationCoordinate2D(latitude: 33.81209940504177, longitude: -117.91897704431926)
    let span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    

    }


    @IBAction func switchMap(_ sender:
                                UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        default:
            mapView.mapType = .hybrid
        }
    }
    
    @IBAction func actPin(_ sender: Any) {
        let mark = MyAnnotation(title: "디즈니 랜드", subtitle: "캘리포니아", mapURL: "https://google.com", coordinate: location, thumbNail: "disney")
        mark.coordinate = location
        mapView.addAnnotation(mark)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var pinView: MKAnnotationView?
        
        guard let myAnnotation = annotation as? MyAnnotation else {
            return nil
        }
        
        if let tempView = mapView.dequeueReusableAnnotationView(withIdentifier: "pin") {
            pinView = tempView
            // 타이틀과 서브타이틀을 넣는다.
            pinView?.annotation = myAnnotation
            let imageView = pinView?.leftCalloutAccessoryView as? UIImageView
            if let imageName = myAnnotation.thumbNail {
                let image = UIImage(named: imageName)
                imageView?.image = image
            }
        } else {
            pinView = MKPinAnnotationView(annotation: myAnnotation, reuseIdentifier: "pin")
            pinView?.canShowCallout = true
            
            if let imageName = myAnnotation.thumbNail {
                let image = UIImage(named:imageName)
                let imageView = UIImageView(image: image)
                imageView.frame.size = CGSize(width: 60, height: 40)
                pinView?.leftCalloutAccessoryView = imageView
            }
            
            
            let button = UIButton(type: .detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
        }
        
        
        return pinView
    }
    
//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//        <#code#>
//    }
    
}

