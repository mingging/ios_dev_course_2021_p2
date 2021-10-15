//
//  ViewController.swift
//  QRScannerTest
//
//  Created by minimani on 2021/10/15.
//

import UIKit
import SwiftQRScanner
import AVFoundation

class ViewController: UIViewController, QRScannerCodeDelegate {
    
    @IBOutlet weak var lblLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func qrScanner(_ controller: UIViewController, scanDidComplete result: String) {
        lblLabel.text = result
    }
    
    func qrScannerDidFail(_ controller: UIViewController, error: String) {
        print(error)
    }
    
    func qrScannerDidCancel(_ controller: UIViewController) {
        print("Scan canceled")
    }

    @IBAction func actScan(_ sender: UIButton) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            let scanner = QRCodeScannerController()
            scanner.delegate = self
            present(scanner, animated: true)
        case .restricted:
            print("제한됨")
        case . notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    let scanner = QRCodeScannerController()
                    scanner.delegate = self
                    self.present(scanner, animated: true)
                }
            }
            print("결정안됨")
        case .denied:
            print("거부됨")
        
        }
        
        
    }
    
}

